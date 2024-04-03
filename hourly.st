Employee subclass: HourlyEmployee [
    | hoursWorked hourlyRate salary calculatedSalary|
    
    setHoursWorked: hours[
        hoursWorked := hours asScaledDecimal: 2.
    ]

    setHourlyRate: rate[
        hourlyRate := rate asScaledDecimal: 2.
    ]

    printInfo [
        Transcript show: 'Hourly employee: ', self fullName; cr.
        Transcript show: 'Hours worked: ', (self hours asString), ', hourly rate: ', (self rate asString); cr. "Convert salary to string before output"
        Transcript show: 'earned $', (self salary asString); cr. "Convert salary to string before output"
        Transcript cr.
    ]

    getSalary [
        ^self salary.
    ]
    
    salary [
        | calculatedSalary |
        calculatedSalary := 0.
        hoursWorked <= 40 ifTrue: [
            calculatedSalary := (hoursWorked * hourlyRate).
        ].
        hoursWorked > 40 ifTrue: [
            hoursWorked <= 50 ifTrue: [
                calculatedSalary := (40 * hourlyRate) + ((hoursWorked - 40) * (hourlyRate * 1.5)).
            ]
        ].
        hoursWorked > 50 ifTrue: [
            calculatedSalary := (40 * hourlyRate) + (10 * (hourlyRate * 1.5)) + ((hoursWorked - 50) * (hourlyRate * 2)).
        ].
        ^calculatedSalary asScaledDecimal: 2.
    ]

    hours [
        ^hoursWorked asScaledDecimal: 2.
    ]

    rate [
        ^hourlyRate asScaledDecimal: 2.
    ]
]
