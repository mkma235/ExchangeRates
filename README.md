# ExchangeRates
## Mariano Manuel

## (0)Synopsis

**(0.1)To Compile:**
Type "command+B" in your Xcode project to compile the program.  

**(0.2)To Run:**
Type "command+R" in your Xcode project to run the program.  

**(0.3)Input:**
There is no input needed to initiate the program. However, there is a Button and a DatePicker component. The button displays an Exchange Rates graph while the DatePicker is used to modify one of the dates displayed on the graph.  

**(0.4)Output:**
There is a graph displaying the Exchange Rates from EUR to USD. In another view, there are multiple Conversion Rates displayed to the user.  

## (1)Included Files
README.md - This file  
EditRates.swift - View displaying Conversion Rates and DatePicker to modify graph  
ExchangeRatesApp.swift - App starter file  
Graph.swift - View displaying graph given data points  
Info.plist - App settings  
Month+CoreDataClass.swift - NSManagedObject Entity Month  
Month+CoreDataProperties.swift - Entitity Month Property Variables  
Persistence.swift - Core Data Persistence Container  
Rate.swift - Struct defining a Rate Object  
Rates.swift - View Displaying EUR to USD Exchange Rate and Exchange Rates Graph  
ExchangeRatesTests.swift - XCTests which test program funcionality  
Info.plist - XCTest Settings  
ExchangeRatesUITests.swift - UITests which test program UI/UX  
Info.plist - UITest Settings  

## (2)Bugs/Limitations
Program Graph deletes oldest date when modifying graph points. Did not determine how to delete closest date to modified date in the graph points. Graph still displays points properly.  

## (3)Description
This program provides the Exchange Rate from EUR to USD while also displaying a graph with the Exchange Rates for the previous year. The graph presents the last twelve months with their corresponding Exchange Rates. Clicking the red button will display the graph through on animation. If you click the 'Sample' button, a modal view is presented. Here, you can see the Conversion Rates from EUR to the following coin values: JPY, GBP, MXN, USD, CAD. Below the Conversioin Rates is a DatePicker which is used to add that date and its corresponding Exchange Rate to the graph. The oldest date is tossed out. To update the graph, click on the 'Rates' button. Simply dismissing the view will bring you back to the original viwe without updating any values.  

## (4)Modifications
It was pretty difficult to estimate which point in the graph is closest to the date that the user wants to modify so updating the graph simply removes the oldest date in the graph. This was a bit undesired because it was originally intended to have strict points displayed on the graph. That is, one point per month of the previous year of Exchange Rates.  

## (5)Example

**(5.1)Input:**
There is no input needed to calculate the Exchange Rates, calculate the Conversion Rates, or display the graph. Simply press the red button.  
DatePicker - select date and press 'Rates' button to update graph  

**(5.2)Computation:**
Graph points automattically calculated in the beginning. For loop creating a date of the first day of the month for each month in the previous year. API is called for each date to return the Exchange Rates for each month of the year. When modifying a date, a single API call is needed to calculate the value for the Exchange Rate. 'Rates' button deletes the oldest date and adds the custom date selected from the DatePicker. Five API calls are made to get the Conversion Rates from EUR to 5 different countries.  

**(5.3)Output:**  
Graph displays 12 months worth of data. One point per month displaying the Exchange Rates from EUR to USD. An animation draws the graph onto the view. Five Conversion Rates are also displayed for each of the 5 selected countries.  

## (6)Testing

**(6.1)Experimental Setup:**  
For XCTests, a URLSession is initiated along with providing 2 sample API URL for the functionality tests. For XCUITests, a XCUIApplication was launched.  

**(6.2)Tests:**  

######	(6.2.1)testValidHTTPStatusCode200  
This test makes an API call and the status code is tested. If the status code is a 200 code, then the test passes. The API call tested is the Latest Exchange Rate.  

######	(6.2.2)testAPICallCompletes  
This test makes an API call and the completion handler is tested. If the completion handler is invoked, then the test passes. The test also checks that no error was thrown. The API call tested is the Historical Exchange Rate.  

######	(6.2.3)testRatesLayout  
This test checks the UI/UX layout of the application. Specifically checking the layout of the first view. Various text is checked to see if they are properly displayed. The 'Show Rates' and 'Sample' button are checked to see if they are displayed also. If everything is displayed properly, the test passes.  

######	(6.2.4)testNextViewLayout  
This test checks if the app can properly move from one view to another. The 'Sample'  button is tapped and then various text is checked to see if they are properly displayed. The DatePicker in the second view is checked for existence. If the XCUIApplication moves from one view to the next and properly displays UI/UX components, then the test passes.  

**(6.3)Analysis:**  
There were not many coding setbacks to this program. Primarily because the stored data was not very large. For the graph, there were only 12 dates being plotted and I had changed the program to modify a date instead of adding more to the amount of months plotted on the graph. If there were more points needing to be graphed, then there would be a chance for app unresponsiveness. If that happened, concurrent threads would be needed to properly load the data from the API calls. However, since there were only 12 points, the app did not slow down. The app could have an update which allows the user to add more points to the graph if concurrent threading is implemented. Graphing the points would also take up more time if more points are allowed to be stored on the app.  
