//
//  Home_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/19.
//

import UIKit


class Home_ViewController: UIViewController {

    
    
    
    @IBOutlet var img_banner: UIImageView!
    
    
    // 배너이미지 리스트
    var images = [ "b1.png", "b2.png", "b3.png",]
    
    //타이머 변수 선언
    var timer : Timer?
    //타이머에 사용할 번호값
    var timerNum: Int = 0
    
    let imageSelector:Selector = #selector(imageTimer)
    
    @IBOutlet var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 페이지컨트롤러 설정
        didLoad_PageControl()
       
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: imageSelector, userInfo: nil, repeats: true)
        
    }
    // 페이지 컨트롤 초기설정하기
    func didLoad_PageControl(){
        //페이지 컨트롤의 전체 페이지를 images 배열의 전체 개수 값으로 설정
        pageControl.numberOfPages = images.count
        // 페이지 컨트롤의 현재 페이지를 0으로 설정
        pageControl.currentPage = 0
        // 페이지 표시 색상을 밝은 회색 설정
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        // 현재 페이지 표시 색상을 검정색으로 설정
        pageControl.currentPageIndicatorTintColor = UIColor.red
        img_banner.image = UIImage(named: images[0])
    }

    @objc func imageTimer(){
        
        // 이미지 변환
        img_banner.image = UIImage(named: images[timerNum])
        // 페이지컨트롤러 순서
        pageControl.currentPage = timerNum
        // 타이머숫자 1증가
        timerNum += 1
        // 타이머숫자가 3이면 0으로 초기화
        if timerNum == 3{
            timerNum = 0
        }
        
    }
    
    @IBAction func btn_shop(_ sender: UIButton) {
        // 메인페이지로 넘어가기
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "Shop_View")
                vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                self.present(vcName!, animated: true, completion: nil)
    }
    
    
    @IBAction func PageControl(_ sender: UIPageControl) {
        
        // images라는 배열에서 pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imgView에 할당
        img_banner.image = UIImage(named: images[pageControl.currentPage])
    }
    
    
    
    
    
    
    
    
    
}
