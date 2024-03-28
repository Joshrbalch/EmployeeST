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
        Transcript show: 'Salaried employee: ', self fullName; cr.
        Transcript show: 'weekly salary: ', (self salary asString); cr. "Convert salary to string before output"
        Transcript show: 'earned: $', self salary asString; cr.
        Transcript cr.
    ]
    
    salary [
        ^salaryAmount "Return the salary amount"
    ]
]
