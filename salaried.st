Employee subclass: SalariedEmployee [
    | salaryAmount |

    init [
        <category: 'initialization'>
        super init. "Call the superclass init method"
        salaryAmount := 0. "Initialize the salary amount"
    ]
    
    salary: aSalary [
        salaryAmount := aSalary. "Set the salary amount"
    ]

    printInfo [
        super printInfo.
        Transcript show: 'Salary: ', (self salary asString); cr. "Convert salary to string before output"
    ]
    
    salary [
        ^salaryAmount "Return the salary amount"
    ]
]
