//
//  BluetoothVC.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/27.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "BluetoothVC.h"

#import <CoreBluetooth/CoreBluetooth.h>


@interface BluetoothVC ()<CBCentralManagerDelegate,CBPeripheralDelegate>

////中心管理者
@property (nonatomic,strong) CBCentralManager *manager;

///连接的外设
@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic,strong) NSTimer *connectTimer;

@end

@implementation BluetoothVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    // Do any additional setup after loading the view.
}
///只要中心管理者初始化，就会触发这个方法，判断手机蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case 0:
            NSLog(@"中心管理者状态未知");
            break;
        case 1:
            NSLog(@"中心管理者状态重置");
            break;
        case 2:
            NSLog(@"不支持蓝牙");
            break;
        case 3:
            NSLog(@"未经授权");
            break;
        case 4:
            NSLog(@"蓝牙未开启");
            break;
        case 5:
        {
             NSLog(@"蓝牙已开启");
            ///成功开启后进行操作
            ///搜索外设
            [self.manager scanForPeripheralsWithServices:nil///通过某些服务筛选外设
                                                 options:nil]; ///dict 条件
            // 搜索成功之后,会调用我们找到外设的代理方法
            // - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设
        }
            break;
        default:
            break;
    }
}
///查找设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSLog(@"%@",peripheral.identifier);
    ///每个蓝牙都有一个自己的唯一的标识符，根据标识符确认自己要连接的设备
    if ([peripheral.identifier isEqual:self.peripheral.identifier]) {
        self.peripheral = peripheral;
        ///数据连接定时器
        self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(connentPeripheral) userInfo:@"timer" repeats:YES];
    }
}
- (void)connentPeripheral {
    //连接外设
    self.manager.delegate = self;
    [self.manager connectPeripheral:_peripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
    
}
///连接成功厚调用
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"did connect to peripheral :%@--%@",peripheral,peripheral.name);
    [peripheral setDelegate:self];///查找服务
    [peripheral discoverServices:nil];
    
    [self.connectTimer invalidate];
    ///检测设备是否断开了
}
//当监听到失去和外围设备连接，重新建立连接
//这个方法是必须实现的，因为蓝牙会中断连接，正好触发这个方法重建连接。重建连接可能造成数秒后才能读取到RSSI。

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [self.manager connectPeripheral:peripheral options:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@",error.description);
}

//返回的蓝牙服务通知通过代理实现
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error)
    {
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    for (CBService *service in peripheral.services)
    {
        //        NSLog(@"Service found with UUID: %@", service.UUID.UUIDString);
        //发现服务
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180D"]])//heart rate
        {
            //在一个服务中寻找特征值
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

//返回的蓝牙特征值通知通过代理实现
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    for (CBCharacteristic * characteristic in service.characteristics)
    {
        NSLog(@"characteristic:%@",characteristic);
        if( [characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A37"]])
        {
            
            [self notification:service.UUID characteristicUUID:characteristic.UUID peripheral:peripheral on:YES];
            //            [self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

//处理蓝牙发过来的数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}

-(void) notification:(CBUUID *) serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)p on:(BOOL)on
{
    CBService *service = [self getServiceFromUUID:serviceUUID p:p];
    if (!service)
    {
        //        if (p.UUID == NULL) return; // zach ios6 addedche
        //        NSLog(@"Could not find service with UUID on peripheral with UUID \n");
        return;
    }
    CBCharacteristic *characteristic = [self getCharacteristicFromUUID:characteristicUUID service:service];
    if (!characteristic)
    {
        //        if (p.UUID == NULL) return; // zach ios6 added
        //        NSLog(@"Could not find characteristic with UUID  on service with UUID  on peripheral with UUID\n");
        return;
    }
    [p setNotifyValue:on forCharacteristic:characteristic];
    
}

-(CBService *) getServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p
{
    
    for (CBService* s in p.services)
    {
        if ([s.UUID isEqual:UUID]) return s;
    }
    return nil; //Service not found on this peripheral
}
-(CBCharacteristic *) getCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service {
    
    for (CBCharacteristic* c in service.characteristics)
    {
        if ([c.UUID isEqual:UUID]) return c;
    }
    return nil; //Characteristic not found on this service
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
