Employee subclass: CommissionEmployee [
    | baseSalary salesAmount commissionRate calculatedSalary|
    
    setBasePay: basePay [
        baseSalary := basePay asScaledDecimal: 2.
    ]

    setSales: sales [
        salesAmount := sales asScaledDecimal: 2.
    ]

    setBaseCommissionRate: rate [
        commissionRate := rate asScaledDecimal: 2.
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
            ^ baseSalary asScaledDecimal: 2.
        ] ifFalse: [
            ^ calculatedSalary asScaledDecimal: 2.
        ].
    ]

    getSalary [
        ^ self salaryCalc asScaledDecimal: 2.
    ]

    baseSalary [
        ^baseSalary asScaledDecimal: 2.
    ]

    sales [
        ^salesAmount asScaledDecimal: 2.
    ]

    rate [
        ^commissionRate asScaledDecimal: 2.
    ]
]
