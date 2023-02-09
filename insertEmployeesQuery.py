import csv
import random
from faker import Faker


def readCSV(fileName: str):
    rowsList = []
    with open(fileName, "r") as theFile:
        readFile = csv.reader(theFile)
        for X in readFile:
            rowsList.append(X)
    return rowsList


def insertQueryEmployeeDetailsFromCSV(tableName: str, fileName: str):
    fileRows = readCSV(fileName)
    tableHeaders = "First_Name, Last_Name, Street_Address, City, Postcode, Salary, DOB, NIN"
    valuesToInsert = []
    for X in fileRows[1:]:
        newList = []
        Count = 0
        for Y in X:
            if (Count == 1):
                Y = Y.split()
                newList.append(str("\"") + Y[0] +
                               str("\",\"") + Y[1] + str("\""))
            elif (Count == 2):
                newList.append(str("\"") + Y + str("\",\"") + ukCities[random.randint(
                    0, len(ukCities) - 1)] + str("\",\"") + "".join(fake.address()[-8:].split()) + str("\""))
            elif (Count == 3):
                newList.append("".join(Y.split(",")))
            elif (Count == 4):
                Y = Y.split("/")
                newList.append(str("\"") + Y[2] + str("-") + Y[1] +
                               str("-") + Y[0] + str("\""))
            elif (Count == 5):
                newList.append(str("\"") + Y.upper() + str("\""))
            Count += 1
        valuesToInsert.append("\t({})".format(",".join(newList)))
    return "INSERT INTO {} ({}) VALUES\n {};".format(tableName, tableHeaders, ",\n".join(valuesToInsert))


def insertQueryEmployeesFromCSV(tableName: str, fileName: str):
    fileRows = readCSV(fileName)
    tableHeaders = "Number, NIN, Department_Number"
    valuesToInsert = []
    for X in fileRows[1:]:
        newList = []
        Count = 0
        for Y in X:
            if (Count == 0):
                newList.append(str("\"") + Y + str("\""))
            elif (Count == 5):
                newList.append(str("\"") + Y.upper() + str("\""))
            elif (Count == 6):
                if (Y == "Driver"):
                    newList.append(str(1))
                elif (Y == "HR"):
                    newList.append(str(2))
                elif (Y == "Manager"):
                    newList.append(str(3))
                elif (Y == "Packager"):
                    newList.append(str(4))
            Count += 1
        valuesToInsert.append("\t({})".format(",".join(newList)))
    return "INSERT INTO {} ({}) VALUES\n {};".format(tableName, tableHeaders, ",\n".join(valuesToInsert))


def insertQueryEmergencyContactsFromCSV(tableName: str, fileName: str):
    fileRows = readCSV(fileName)
    tableHeaders = "Employee_Number, First_Name, Last_Name, Relationship, Phone_Number"
    valuesToInsert = []
    for X in fileRows[1:]:
        newList = []
        Count = 0
        for Y in X:
            if (Count == 5):
                newList.append(
                    "(SELECT Number FROM Employees WHERE NIN = '{}')".format(Y.upper()))
            elif (Count == 7):
                Y = Y.split()
                newList.append(str("\"") + Y[0] +
                               str("\",\"") + Y[1] + str("\""))
            elif (Count == 8):
                newList.append(str("\"") + Y + str("\""))
            elif (Count == 9):
                newList.append(str("\"") + "".join(Y.split()) + str("\""))
            Count += 1
        valuesToInsert.append("\t({})".format(",".join(newList)))
    return "INSERT INTO {} ({}) VALUES\n {};".format(tableName, tableHeaders, ",\n".join(valuesToInsert))


def insertQueryForEmployeeType(tableName: str, fileName: str, employeeType: str):
    fileRows = readCSV(fileName)
    if (employeeType == "HR" or employeeType == "Manager"):
        tableHeaders = "Employee_Number, Office_ID"
    elif (employeeType == "Packager"):
        tableHeaders = "Employee_Number"
    elif (employeeType == "Driver"):
        tableHeaders = "Employee_Number, Hours_Per_Week"
    valuesToInsert = []
    for X in fileRows[1:]:
        newList = []
        Count = 0
        for Y in X:
            if (Count == 5):
                getEmployeeIDQuery = "(SELECT Number FROM Employees WHERE NIN = '{}')".format(
                    Y.upper())
            if (Count == 6):
                if (Y == employeeType and (employeeType == "HR" or employeeType == "Manager")):
                    newList.append(getEmployeeIDQuery)
                    newList.append(
                        "(SELECT ID FROM Offices ORDER BY RAND() LIMIT 1)")
                if (Y == employeeType and employeeType == "Driver"):
                    newList.append(getEmployeeIDQuery)
                    newList.append(str(random.randint(12, 50)))
                if (Y == employeeType and employeeType == "Packager"):
                    newList.append(getEmployeeIDQuery)
            Count += 1
        if (len(newList) > 0):
            valuesToInsert.append("\t({})".format(",".join(newList)))
    return "INSERT INTO {} ({}) VALUES\n {};".format(tableName, tableHeaders, ",\n".join(valuesToInsert))


def insertQuery(tableName: str, tableHeaders: str, theValues):
    return f"INSERT INTO {tableName} ({tableHeaders}) VALUES\n ({theValues});"


def updateQuery(tableName: str, valuesToUpdate: str, theCondition: str):
    return f"UPDATE {tableName} SET {valuesToUpdate} WHERE {theCondition};"


ukCities = [
    "Bath", "Birmingham", "Bradford", "Brighton & Hove", "Bristol", "Cambridge", "Canterbury", "Carlisle", "Chelmsford", "Chester", "Chichester", "Colchester", "Coventry", "Derby", "Doncaster", "Durham", "Ely", "Exeter", "Gloucester", "Hereford", "Kingston-upon-Hull", "Lancaster", "Leeds", "Leicester", "Lichfield", "Lincoln", "Liverpool", "London", "Manchester", "Milton Keynes", "Newcastle-upon-Tyne", "Norwich", "Nottingham", "Oxford", "Peterborough", "Plymouth", "Portsmouth", "Preston", "Ripon", "Salford", "Salisbury", "Sheffield", "Southampton", "Southend-on-Sea", "St Albans", "Stoke on Trent", "Sunderland", "Truro", "Wakefield", "Wells", "Westminster", "Winchester", "Wolverhampton", "Worcester", "York", "Armagh", "Bangor", "Belfast", "Lisburn", "Londonderry", "Newry", "Aberdeen", "Dundee", "Dunfermline", "Edinburgh", "Glasgow", "Inverness", "Perth", "Stirling", "Cardiff", "Newport", "St Asaph", "St Davids", "Swansea", "Wrexham"
]

fake = Faker()
