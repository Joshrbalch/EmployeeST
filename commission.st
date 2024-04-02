Employee subclass: CommissionEmployee [
    | baseSalary salesAmount commissionRate calculatedSalary|
    
    setBasePay: basePay [
        baseSalary := basePay.
    ]

    setSales: sales [
        salesAmount := sales.
    ]

    setBaseCommissionRate: rate [
        commissionRate := rate.
    ]

    printInfo [
        Transcript show: 'Commission employee: ', self fullName; cr.
        Transcript show: 'minimum salary: ', self baseSalary asString, ', sales amount: ', self sales asString, ', commission rate: ', (self rate * 100) asString, '%'; cr. "Convert commission rate to percentage string"
        Transcript show: 'earned $', self salaryCalc asString; cr.
        Transcript cr.
    ]

    salaryCalc [
        | calculatedSalary |
        calculatedSalary := salesAmount * commissionRate.

        calculatedSalary <= baseSalary ifTrue: [
            ^ baseSalary asNumber
        ] ifFalse: [
            ^ calculatedSalary asNumber
        ].
    ]

    getSalary [
        ^ self salaryCalc
    ]

    baseSalary [
        ^baseSalary.
    ]

    sales [
        ^salesAmount.
    ]

    rate [
        ^commissionRate
    ]
]
