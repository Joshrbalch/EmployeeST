mySal := SalariedEmployee new.
mySal salary: 50000. "Set the salary"
mySal setFirstName: 'John'.
mySal setLastName: 'Doe'.
mySal printInfo.
MyHourly := HourlyEmployee new.
MyHourly hoursWorked: 40 rate: 8.
MyHourly setFirstName: 'Jane'.
MyHourly setLastName: 'Smith'.
MyHourly printInfo.
MyCom := CommissionEmployee new.
MyCom baseSalary: 50 sales: 400 rate: 0.25.
MyCom setFirstName: 'Jim'.
MyCom setLastName: 'Jones'.
MyCom printInfo.

