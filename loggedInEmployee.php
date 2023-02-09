<?php

// Class To Instantiate An Object Of The Logged In Employee
class Employee
{

    private $employeeNum;
    private $NIN;
    private $departmentNumber;
    private $managerID;
    private $fName;
    private $lName;
    private $streetAddress;
    private $City;
    private $postCode;
    private $DOB;
    private $Salary;

    function __construct(
        $EmployeeNumber,
        $NationalInsuranceNumber,
        $departmentNumber,
        $managerID,
        $fName,
        $lName,
        $streetAddress,
        $City,
        $postCode,
        $DOB,
        $Salary
    ) {
        $this->employeeNum = $EmployeeNumber;
        $this->NIN = $NationalInsuranceNumber;
        $this->departmentNumber = $departmentNumber;
        $this->managerID = $managerID;
        $this->fName = $fName;
        $this->lName = $lName;
        $this->streetAddress = $streetAddress;
        $this->City = $City;
        $this->postCode = $postCode;
        $this->DOB = $DOB;
        $this->Salary = $Salary;
    }

    function getEmployeeNumber()
    {
        return $this->employeeNum;
    }

    function getNIN()
    {
        return $this->NIN;
    }

    function getDepartmentNumber()
    {
        return $this->departmentNumber;
    }

    function getManagerID()
    {
        return $this->managerID;
    }

    function getFirstName()
    {
        return $this->fName;
    }

    function getLastName()
    {
        return $this->lName;
    }

    function getStreetAddress()
    {
        return $this->streetAddress;
    }

    function getCity()
    {
        return $this->City;
    }

    function getPostcode()
    {
        return $this->postCode;
    }

    function getDOB()
    {
        return $this->DOB;
    }

    function getSalary()
    {
        return $this->Salary;
    }
}
