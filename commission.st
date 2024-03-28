Employee subclass: CommissionEmployee [
    | baseSalary salesAmount commissionRate |
    
    baseSalary: salary sales: sales rate: rate [
        baseSalary := salary.
        salesAmount := sales.
        commissionRate := rate
    ]

    printInfo [
        Transcript show: 'Commission employee: ', self fullName; cr.
        Transcript show: 'minimum salary: ', baseSalary printString, ', sales amount: ', self sales asString, ', commission rate: ', (self rate * 100) asString, '%'; cr.
        Transcript show: 'earned $', self salaryCalc printString; cr.
        Transcript cr.
    ]


    salaryCalc [
        | calculatedSalary |
        calculatedSalary := baseSalary <= (salesAmount * commissionRate)
            ifTrue: [ baseSalary ]
            ifFalse: [ salesAmount * commissionRate ].
        ^ calculatedSalary
    ]

    baseSalary [
        ^baseSalary
    ]

    sales [
        ^salesAmount
    ]

    rate [
        ^commissionRate
    ]
]
