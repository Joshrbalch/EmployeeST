Object subclass: Employee [
    | name |
    Employee class >> new [
        ^super new initialize
    ]
    Employee >> initialize [
        name := 'John Doe'
    ]
    Employee >> name [
        ^name
    ]
    Employee >> name: aString [
        name := aString
    ]
]