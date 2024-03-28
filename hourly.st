Employee subclass: HourlyEmployee [
    | hoursWorked hourlyRate |
    
    hoursWorked: hours rate: rate [
        hoursWorked := hours.
        hourlyRate := rate
    ]

    printInfo [
        Transcript show: 'Hourly employee: ', self fullName; cr.
        Transcript show: 'Hours worked: ', (self hours asString), ', hourly rate: ', (self rate asString); cr. "Convert salary to string before output"
        Transcript show: 'Earned: $', (self salary asString); cr. "Convert salary to string before output"
        Transcript cr.
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
