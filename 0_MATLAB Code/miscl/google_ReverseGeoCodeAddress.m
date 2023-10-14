%MAPS_HOST = 'maps.googleapis.com';
%KEY='AIzaSyCXh41SMumf1CkCGW0OjpQwMCrM3fQyhJU';
 %request_url =[ 'https://' MAPS_HOST '/maps/api/geocode/xml?latlng=40.714224,-73.961452&key='  KEY];
 request_url ='https://maps.googleapis.com/maps/api/geocode/xml?latlng=40.714224,-73.961452&key=AIzaSyCXh41SMumf1CkCGW0OjpQwMCrM3fQyhJU';
    try
    data_string = webread(request_url);
    docNode = ConvertToXmlObject(data_string);
    resultList = getElementsByTagName(docNode, 'address_component');
    catch  
        
    end
    
function xmlTreeObject = ConvertToXmlObject(xmlString)  
    % Store the XML data in a temp *.xml file
    filename = 'Y:\59_MTFC Math Competition\Project Data\temp.xml';
    fid = fopen(filename,'Wt');
    fwrite(fid,xmlString);
    fclose(fid);

    % Read the file into an XML model object
    try
        xmlTreeObject = xmlread(filename);
    catch
        error('Failed to read XML file %s', filename);
    end
    % Delete the temp file
    delete(filename);    
end

    % Loop over the results and create a struct for them
%resultList = docNode.getElementsByTagName('address_components');
% results = [];
% for idx = 1:resultList.getLength
%     resultNode = resultList.item(idx-1);
%     results(idx).coords = char(GetElementText(resultNode,'coordinates'));
%     lat_lon= findstr(',',results(idx).coords);
%     results(idx).Latitude = results(idx).coords(1:lat_lon(1)-1);
%     results(idx).Longitude = results(idx).coords(lat_lon(1)+1:lat_lon(2)-1);
%     results(idx).Address = GetElementText(resultNode,'ThoroughfareName');
%     results(idx).City = GetElementText(resultNode,'LocalityName');
%     results(idx).State = GetElementText(resultNode,'AdministrativeAreaName');
%     results(idx).Zip = GetElementText(resultNode,'PostalCodeNumber');
%     results(idx).Country = GetElementText(resultNode,'CountryName');
% end
% disp('Latitude is')
% disp(results.Latitude)
% disp('Longitude is')
% disp(results.Longitude)
% end
% function elementText = GetElementText(resultNode,elementName)
%     % GETELEMENTTEXT given a result node and an element name
%     % returns the text within that node
%     elementText = ...
%         resultNode.getElementsByTagName(elementName).item(0).getTextContent;
% end
