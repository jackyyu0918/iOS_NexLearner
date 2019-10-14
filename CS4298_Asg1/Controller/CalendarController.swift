     //
     //  CalendarController.swift
     //  CS4298_Asg1
     //
     //  Created by CHAN Yat Chau on 14/10/2019.
     //  Copyright © 2019 YU Ka Kit. All rights reserved.
     //
     
     import UIKit
     
     class CalendarController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
        
        
        @IBOutlet weak var calendar: UICollectionView!
        @IBOutlet weak var timeLabel: UILabel!
        
        
        var currentDay = Calendar.current.component(.day, from: Date())
        var currentMonth = Calendar.current.component(.month, from: Date())
        var currentYear = Calendar.current.component(.year, from: Date())

        var calendarYear = Calendar.current.component(.year, from: Date())
        var calendarMonth = Calendar.current.component(.month, from: Date())
        var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        
        
        override func  viewDidLoad() {
            super.viewDidLoad()
            setUp()
        }
        
        @IBAction func nextMonth(_ sender: Any) {
            calendarMonth += 1
            if calendarMonth == 13{
                calendarMonth = 1
                calendarYear += 1
            }
            setUp()
        }
        
        @IBAction func lastMonth(_ sender: Any) {
            calendarMonth -= 1
            if calendarMonth == 0{
                calendarMonth = 12
                calendarYear -= 1
            }
            setUp()
        }
        
        @IBAction func currentDate(_ sender: Any) {
            calendarYear = Calendar.current.component(.year, from: Date())
            calendarMonth = Calendar.current.component(.month, from: Date())
            setUp()
        }
        
        //    var numberOfDaysInThisMonth:Int{
        //        let dateComponents = DateComponents(year: currentYear,month: currentMonth)
        //        let date = Calendar.current.date(from: dateComponents)!
        //        let range = Calendar.current.range(of: .day, in: .month, for: date)
        //        print("\(currentMonth):\(currentYear):\(range?.count ?? 0)")
        //        return range?.count ?? 0
        //    }
        
        var isLeapYear:Bool{
            var leapYear = calendarYear%4 == 0
            return leapYear
        }
        
        var dayToEnd:Int{
            let dateComponents = DateComponents(year: calendarYear,month: calendarMonth)
            var range = 0
            
            switch calendarMonth {
            case 1,3,5,7,8,10:
                range = 31
            case 4,6,9,11:
                range = 30
            case 2:
                range = 29
            case 12:
                range = isLeapYear ? 31 : 30
            default:
                range = 0
            }
            
            //        print("dayToEnd = currentMonth: \(currentMonth) - currentYear: \(currentYear) - range: \(range)")
            
            return range
        }
        
        var whatDayIsIt:Int{
            let dateComponents = DateComponents(year: calendarYear,month: calendarMonth)
            let date = Calendar.current.date(from: dateComponents)!
            return Calendar.current.component(.weekday, from: date)
        }
        
        var dayToStart:Int{
            var dayToAdd = 0
            switch calendarMonth {
            case 1,4,7,10:
                dayToAdd = 0
            case 5:
                dayToAdd = 2
            case 2,8,11:
                dayToAdd = 3
            case 3:
                dayToAdd = 4
            case 6,9,12:
                dayToAdd = 5
            default:
                dayToAdd = 0
            }
            
            //        print("howManyItemsShouldIAdd = currentMonth: \(currentMonth) - dayToAdd: \(dayToAdd)")
            
            return dayToAdd
        }
        
        func setUp(){
            timeLabel.text = months[calendarMonth - 1] + " \(calendarYear)"
            calendar.reloadData()
        }
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 42
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            if let textLabel = cell.contentView.subviews[0] as? UILabel{
                if (indexPath.row < dayToStart){
                    textLabel.text = ""}
                else if(isLeapYear && calendarMonth == 12){
                    if (indexPath.row < dayToStart){
                        textLabel.text = ""}
                    else if(indexPath.row <  dayToStart + dayToEnd - 1){
                        textLabel.backgroundColor = UIColor.lightGray
                        textLabel.text = "\(indexPath.row + 1 - dayToStart)"}
                    else if(indexPath.row == 41){
                        textLabel.backgroundColor = UIColor.yellow
                        textLabel.text = "31"}
                    else{
                        textLabel.text = ""
                    }
                }
                else if(indexPath.row - dayToStart < dayToEnd){
                    textLabel.backgroundColor = UIColor.lightGray
                    textLabel.text = "\(indexPath.row + 1 - dayToStart)"}
                else{
                    textLabel.text = ""
                }
                
//               Paint long staturday
                if(calendarMonth == 8 && indexPath.row - dayToStart + 1  == 1){
                    textLabel.backgroundColor = UIColor.blue
                }
                
//              Paint today in green
                if(calendarYear == currentYear && calendarMonth == currentMonth && indexPath.row + dayToStart + 1  == currentDay){
                    textLabel.backgroundColor = UIColor.green
                }
            }
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width/7
            return CGSize(width: width, height: 40)
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            calendar.collectionViewLayout.invalidateLayout()
            calendar.reloadData()
        }
     }
