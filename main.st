Object subclass: checkThresh [
    | value operation threshold |

    setValue: val [
        value := val.
    ]

    setOperation: op [
        operation := op.
    ]

    setThreshold: thresh [
        threshold := thresh.
    ]

    compareOps [
        | result |
        " Transcript show: 'Threshold: ', threshold printString; cr. "

        result := true.

        operation = 'eq' ifTrue: [
            " Transcript show: 'Value: ', value printString; cr. "
            result := ((value asNumber) = (threshold asNumber)).
        ] ifFalse: [
            operation = 'ne' ifTrue: [
                result := ((value asNumber) ~= (threshold asNumber)).
            ] ifFalse: [
                operation = 'gt' ifTrue: [
                    result := ((value asNumber) > (threshold asNumber)).
                ] ifFalse: [
                    operation = 'lt' ifTrue: [
                        result := ((value asNumber) < (threshold asNumber)).
                    ] ifFalse: [
                        operation = 'ge' ifTrue: [
                            result := ((value asNumber) >= (threshold asNumber)).
                        ] ifFalse: [
                            operation = 'le' ifTrue: [
                                result := ((value asNumber) <= (threshold asNumber)).
                            ].
                        ].
                    ].
                ].
            ].
        ].

        " Transcript show: 'Result: ', result printString; cr. "

        ^ result.
    ]
].

"Check for correct number of arguments"
Smalltalk arguments size >= 2 ifFalse: [
    Transcript show: 'Usage: gst employee.st salaried.st hourly.st commission.st -f main.st datafile action'; cr.
    Transcript show: 'or'; cr.
    Transcript show: 'Usage: gst employee.st salaried.st hourly.st commission.st -f main.st datafile action operator threshold'; cr.
    Transcript cr.
    Transcript show: 'Valid actions: count print min max total avg'; cr.
    Transcript show: 'Valid operators: eq ne gt ge lt le'; cr.
    ^self halt.
].

"Read arguments"
| employeesFile operation THRESHOLD_PRESENT|
THRESHOLD_PRESENT := 0.
employeesFile := (Smalltalk arguments at: 1). "Access the last argument as the file name."
operation := (Smalltalk arguments at: 2).
Smalltalk arguments size > 2 ifTrue: [
    mod := (Smalltalk arguments at: 3).
    threshold := (Smalltalk arguments at: 4).
    THRESHOLD_PRESENT := 1.
].
" Transcript show: operation; cr. "

| employeeList |
employeeList := OrderedCollection new.

"Open and read employees file"
| file fileLines |
file := FileStream open: employeesFile mode: FileStream read. "Use fileNamed: to open the file."
file ifNotNil: [
    fileLines := file contents lines.
    file close.

    fileLines do: [:line |
        | words employeeType firstName lastName otherAttributes |
        words := line substrings.
        words isEmpty ifTrue: [^self]. "Skip empty lines"
        
        employeeType := words first.
        firstName := words second.
        lastName := words third.
        " Transcript show: lastName; cr. "
        otherAttributes := words allButFirst: 3. "Extract remaining attributes"
        
        "Create employee objects based on the type"
        employeeType = 'salaried' ifTrue: [
            | salary |
            salary := otherAttributes first asNumber. "Assuming salary is the first attribute after the name"
            salariedEmp := SalariedEmployee new.
            salariedEmp setFirstName: firstName.
            salariedEmp setLastName: lastName.
            salariedEmp setSalary: salary.
            employeeList add: salariedEmp.
        ].
        employeeType = 'hourly' ifTrue: [
            | hoursRate hoursWorked|
            hoursWorked := otherAttributes first asNumber. "Assuming rate is the first attribute after the name"
            hoursRate := otherAttributes second asNumber. "Assuming hours worked is the second attribute after the name"
            hourlyEmp := HourlyEmployee new.
            hourlyEmp setFirstName: firstName.
            hourlyEmp setLastName: lastName.
            hourlyEmp setHourlyRate: hoursRate.
            hourlyEmp setHoursWorked: hoursWorked.
            employeeList add: hourlyEmp.
        ].
        employeeType = 'commission' ifTrue: [
            | sales baseCommissionRate basePay|
            basePay := otherAttributes first asNumber.
            sales := otherAttributes second asNumber.
            baseCommissionRate := (otherAttributes third asNumber) asFloat.
            commissionEmp := CommissionEmployee new.
            commissionEmp setFirstName: firstName.
            commissionEmp setLastName: lastName.
            commissionEmp setSales: sales.
            commissionEmp setBaseCommissionRate: baseCommissionRate.
            commissionEmp setBasePay: basePay.
            employeeList add: commissionEmp.
        ].
    ].
] ifNil: [
    Transcript show: 'Unable to open ', Smalltalk aguments at: 1, 'for reading'; cr.
    ^self halt.
].

check := 0.

gate := checkThresh new.
gate setOperation: mod.
gate setThreshold: threshold.

"Perform actions based on command-line arguments"
operation = 'count' ifTrue: [
    | emps |
    emps := 0.

    employeeList do: [:employee |
        gate setValue: (employee getSalary) asNumber.
        gate compareOps ifTrue: [
            emps := emps + 1.
        ].
    ].

    Transcript show: 'There are ', emps asString, ' employees'; cr. 
    check := 1.
].

operation = 'print' ifTrue: [
    employeeList do: [:employee | 
        gate setValue: (employee getSalary) asNumber.
        gate compareOps ifTrue: [
            employee printInfo printString.
        ].
    ].
    check := 1.
].

operation = 'min' ifTrue: [
    emp := Employee new.
    emp := employeeList first.

    employeeList do: [:employee |
        gate setValue: (employee getSalary) asNumber.
        gate compareOps ifTrue: [
            (emp getSalary) > (employee getSalary) ifTrue: [emp := employee].
        ].
    ].
    emp printInfo.
    check := 1.
].

operation = 'max' ifTrue: [
    emp := SalariedEmployee new.
    emp setSalary: 0.

    employeeList do: [:employee | 
        gate setValue: (employee getSalary) asNumber.
        gate compareOps ifTrue: [
            bool := (emp getSalary asNumber) < (employee getSalary asNumber).
            (emp getSalary asNumber) < (employee getSalary asNumber) ifTrue: [
                emp := employee.
            ].
        ].
    ].

    emp printInfo.
    check := 1.
].


operation = 'total' ifTrue: [
    | total |
    total := 0.

    employeeList do: [:employee | 
        gate setValue: (employee getSalary) asNumber.
        gate compareOps ifTrue: [
            total := total + (employee getSalary)
        ].
    ].

    Transcript show: 'Total payment is $', total asString; cr.
    check := 1.
].

operation = 'avg' ifTrue: [
    | total averageSalary numEmployees|
    total := 0 asScaledDecimal: 2.
    numEmployees := 0 asScaledDecimal: 2.

    employeeList do: [:employee | 
        gate setValue: (employee getSalary) asNumber.
        gate compareOps ifTrue: [
            total := total + (employee getSalary asNumber).
            numEmployees := numEmployees + 1.
        ].
    ].

    numEmployees <= 0 ifTrue: [
        Transcript show: 'No employees found'; cr.
        check := 1.
    ].

    numEmployees > 0 ifTrue: [
        averageSalary := (total)/(numEmployees).

        Transcript show: 'Average payment per employee is $', averageSalary printString; cr.
        check := 1.
    ].
].

check = 0 ifTrue: [
    Transcript show: 'Unknown operation: ', operation; cr.
].

