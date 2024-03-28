Object subclass: Employee [
    | firstName lastName |
    
    Employee class >> new: aFirst lastName: aLast [
        ^self new setFirstName: aFirst; setLastName: aLast; yourself
    ]
    
    setFirstName: aFirst [
        firstName := aFirst
    ]
    
    setLastName: aLast [
        lastName := aLast
    ]

    printInfo [
        Transcript show: 'First Name: ', firstName; cr.
        Transcript show: 'Last Name: ', lastName; cr.
    ]

    fullName [
        ^firstName, ' ', lastName
    ]
    
    firstName [
        ^firstName
    ]
    
    lastName [
        ^lastName
    ]
]
