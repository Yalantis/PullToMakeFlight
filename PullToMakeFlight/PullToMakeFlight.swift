//
//  Created by Anastasiya Gorban on 5/27/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//
//  Licensed under the MIT license: http://opensource.org/licenses/MIT
//  Latest version can be found at https://github.com/Yalantis/PullToMakeFlight
//

import Foundation
import PullToRefresh

open class PullToMakeFlight: PullToRefresh {
    
    public convenience init(at position: Position) {
        let height: CGFloat = 40
        let refreshView = Bundle(for: type(of: self)).loadNibNamed("FlightView", owner: nil, options: nil)!.first as! FlightView
        refreshView.clipsToBounds = true
        let animator = FlightAnimator(refreshView: refreshView)
        
        self.init(refreshView: refreshView, animator: animator, height: height, position: position)
        
        self.hideDelay = 0.2
    }
}
