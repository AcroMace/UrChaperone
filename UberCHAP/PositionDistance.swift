///import CoreFoundation
class PositionDistance {
    var currAvg = 0.0 ///holds the current average distance for the grouped objects
    let n = 10.0      ///The number of objecs the the rolled average affects at a time. NOTE: the larger the number, the more it gets smoothed

    func rolledAverage(newVal: Double) -> Double {
        currAvg -= currAvg/n
        currAvg += newVal/n
        return currAvg       ///returns smoothed distance
    }
    ///TODO: get quick distance from home
    func getPosFromHome(){
        ///UberRides /v1/Places: Home
    }
}

///HOW TO USE THE CLASS
///let getPos = PositionDistance() ///create an object to calculate the distances
///var dist = 0.0 ///something to store the distances
///NOTE: the for loop will be supstituted witha a continuous flow of data to smooth it out
///for i in stride (from: 0, to: distanceToHome.count, by: 1) {
///    dist = getPos.rolledAverage(newVal: distanceToHome[i])
///    print (dist)
///}