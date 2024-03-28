Employee subclass: HourlyEmployee [
    | hoursWorked hourlyRate |
    
    hoursWorked: hours rate: rate [
        hoursWorked := hours.
        hourlyRate := rate
    ]

    printInfo [
        super printInfo.
        Transcript show: 'Hours: ', (self hours asString); cr. "Convert salary to string before output"
        Transcript show: 'Rate: ', (self rate asString); cr. "Convert salary to string before output"
        Transcript show: 'Salary: ', (self salary asString); cr. "Convert salary to string before output"
    ]
    
    salary [
        ^hoursWorked * hourlyRate
    ]

    hours [
        ^hoursWorked
    ]

    rate [
        ^hourlyRate
    ]
]
