Employee subclass: CommissionEmployee [
    | baseSalary salesAmount commissionRate |
    
    baseSalary: salary sales: sales rate: rate [
        baseSalary := salary.
        salesAmount := sales.
        commissionRate := rate
    ]

    printInfo [
        Transcript
            nextPutAll: 'Commission employee: ', self fullName;
            nextPutAll: 'minimum salary: ', (self baseSalary asString);
            nextPutAll: 'sales amount: ', (self sales asString); cr;
            nextPutAll: 'commission rate: ', ((self rate * 100) asString), '%';
            nextPutAll: 'earned $', (self salaryCalc asString);.
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
