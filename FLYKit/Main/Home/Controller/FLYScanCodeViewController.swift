//
//  FLYScanCodeViewController.swift
//  FLYKit
//
//  Created by fly on 2022/3/10.
//

/*
 
  二维码实现思路
 1.输入设备 (用来获取外界信息) 摄像头、麦克风、键盘等
 2.输出设备 (将收集到的信息做解析，来获取收到的内容)
 3.会话session (用来连接输入和输出设备)
 4.特殊的layer (展示输入设备所采集的信息 (展示摄像头拍摄的信息))
 
 */

import UIKit
import AVFoundation

class FLYScanCodeViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        initUI()
        
        setupScan()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        previewLayer.frame = view.bounds
        containerLayer.frame = view.bounds
        
        
        //设置扫描区域 (只有在[session startRunning]以后调用才有效果!!!)
        //output.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: v.frame)
    }
    
    
    
    // MARK: - UI
    
    private func initUI()
    {
        view.backgroundColor = UIColor.white
    }
    
    private func setupScan()
    {
        //1.判断输入能否添加到会话中
        if !session.canAddInput(input)
        {
            return
        }
        
        //2.判断输出能否添加到会话中
        if !session.canAddOutput(output)
        {
            return
        }
        
        //3.添加输入和输出到会话中
        session.addInput(input)
        session.addOutput(output)
        
        //4.设置输出能够解析的数据类型 （availableMetadataObjectTypes是所有的类型，也可以单独一种）
        //设置类型一定要在输出对象添加到会话之后
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        //5.设置监听输出解析到的数据
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //6.添加预览图层（没有预览涂层实现扫一扫，只是界面上没有摄像头拍摄的画面）
        view.layer.insertSublayer(previewLayer, at: 0)
        
        //7.二维码描边的layer
        view.layer.addSublayer(containerLayer)
        
        //8.开始扫描
        session.startRunning()
        
    }
    
    
    
    // MARK: - 懒加载
    
    //输入对象
    private lazy var input: AVCaptureDeviceInput = {

        let device = AVCaptureDevice.default(for: .video)

        return try! AVCaptureDeviceInput(device: device!)
    }()
    
    
    //会话
    private lazy var session: AVCaptureSession = AVCaptureSession()
    
    
    //输出对象
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    
    //预览图层 （没有预览涂层实现扫一扫，只是界面上没有摄像头拍摄的画面）
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
    
    
    //二维码描边的layer
    private lazy var containerLayer = CALayer()
    
}



// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension FLYScanCodeViewController: AVCaptureMetadataOutputObjectsDelegate
{
    //扫描到结果后调用的代理
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
    {
        //先清空二维码描边
        clearLayers()
        
        
        for obj in metadataObjects
        {
            if let codeObject = obj as? AVMetadataMachineReadableCodeObject
            {
                print("obj =\(codeObject.stringValue ?? "nil")")
                
                
                // corners属性里包含了二维码坐标信息，但它里面并不是屏幕坐标，需要转换
                
                //转换前： codeObject.corners { 0.5,0.6 0.5,0.6 0.5,0.4 0.5,0.4 }
                //转换后： objc.corners { 158.2,420.7 158.2,422.5 251.4,422.5 251.4,420.7 } （分别代表四个点的坐标）
                
                //通过预览将 corners 的值转换为我们能识别的类型
                let objc: AVMetadataObject? = previewLayer.transformedMetadataObject(for: codeObject)
                
                //再转成CodeObject类型
                let codeObjc = objc as? AVMetadataMachineReadableCodeObject
                
                //绘制二维码描边
                drawLines(objc: codeObjc)
                
            }
        }
       
    }
    
    
    //绘制二维码描边
    private func drawLines(objc: AVMetadataMachineReadableCodeObject?) {
        
        guard let array = objc?.corners else
        {
            return
        }
        
        
        //1.创建图层，用于绘制矩形
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        //线的颜色
        layer.strokeColor = UIColor.orange.cgColor
        //填充颜色
        layer.fillColor = UIColor.clear.cgColor
        
        //2.创建UIBezierPath，绘制矩形
        let path = UIBezierPath()
        //2.1 将起点移动到某一个点
        path.move(to: array.first!)
        //2.2链接其他线段
        for poit in array[1...]
        {
            path.addLine(to: poit)
        }
        
        //2.3关闭路径
        path.close()
        
        layer.path = path.cgPath
        
        //3.将用于保存矩形的图层添加到界面上
        containerLayer.addSublayer(layer)
        
    }
    
    
    //清空二维码描边
    private func clearLayers()
    {
        guard let subLayers = containerLayer.sublayers else
        {
            return
        }
        
        for subLayer in subLayers
        {
            subLayer.removeFromSuperlayer()
        }
    }
}
