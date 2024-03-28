Employee subclass: CommissionEmployee [
    | baseSalary salesAmount commissionRate |
    
    baseSalary: salary sales: sales rate: rate [
        baseSalary := salary.
        salesAmount := sales.
        commissionRate := rate
    ]

    printInfo [
        super printInfo.
        Transcript show: 'Base Salary: ', (self baseSalary asString); cr.
        Transcript show: 'Sales: ', (self sales asString); cr.
        Transcript show: 'Commission Rate: ', (self rate asString); cr.
        Transcript show: 'Salary: ', (self salaryCalc asString); cr.
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
