declare variable $error as xs:string external;
declare function local:arrival_airport($flight as element(response)){
    let $arrival_airport := doc("airports.xml")//response[iata_code = $flight/arr_iata]
    let $arrival_country := doc("countries.xml")//response[code = $arrival_airport/country_code]
    return if($arrival_airport/name/text() !="" and $arrival_country/name/text() != "")then
    <arrival_airport>
                    <country>{$arrival_country/name/text()}</country>
                    <name>{$arrival_airport/name/text()}</name>
    </arrival_airport>
    else
    ()
};
declare function local:departure_airport($flight as element(response)){
    let $departure_airport := doc("airports.xml")//response[iata_code = $flight/dep_iata]
    let $departure_country := doc("countries.xml")//response[code = $departure_airport/country_code]
    return if($departure_airport/name/text()!="" and $departure_country/name/text()!="")then
    <departure_airport>
        <country>{$departure_country/name/text()}</country>
        <name>{$departure_airport/name/text()}</name>
    </departure_airport>
    else
    ()
};
<flights_data xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="flights_data.xsd">{
    if($error = 'no')then
    for $flight in doc("flights.xml")/root/response/response
        let $country := doc("countries.xml")//response[code = $flight/flag]
        return <flight id = "{$flight/hex}">
            <country>{$country/name/text()}</country>
            <position>
                <lat>{$flight/lat/text()}</lat>
                <lng>{$flight/lng/text()}</lng>
            </position>
            <status>{$flight/status/text()}</status>
            {local:departure_airport($flight)}
            {local:arrival_airport($flight)}
        </flight>
    else
        <error>Qty must be a numeric value or omitted in the script call</error>
}</flights_data>