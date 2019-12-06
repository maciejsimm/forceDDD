@RestResource(urlMapping='/v1/assetReservation/*')
global with sharing class DDD_AssetReservationREST {


	@HttpPost
	global static void doPost() {
		RestRequest req = RestContext.request;
        ResponseWrapper responseWrapper = new ResponseWrapper();
		DDD_AssetManagementService assetMgmtService = (DDD_AssetManagementService)AppConfig.Service.newInstance(DDD_AssetManagementService.class);

		try {
			AssetReservationRequest requestObject = (AssetReservationRequest)System.JSON.deserialize(req.requestBody.toString(), AssetReservationRequest.class);
            Boolean response = assetMgmtService.assignAsset(requestObject.assetType,
                                                            requestObject.assignmentStartDate,
                                                            requestObject.assetLocation,
                                                            requestObject.employeeId);
            

			responseWrapper.success = true;
			responseWrapper.statusCode = 201;
			responseWrapper.data = String.valueOf(response);

		} catch (Exception e) {
			responseWrapper.success = false;
			RestContext.response.statusCode = 400;
			responseWrapper.statusCode = 400;
			responseWrapper.message = e.getMessage() + ' || '+e.getStackTraceString();
		}

		RestContext.response.addHeader('Content-Type', 'application/json');
		RestContext.response.responseBody = Blob.valueOf(JSON.serialize(responseWrapper));
	}


	global class AssetReservationRequest {
		global String assetType {get;set;}
        global String assetLocation {get;set;}
		global Date assignmentStartDate {get;set;}
		global String employeeId {get;set;}
	}

    global class ResponseWrapper {
        global Boolean success {get;set;}
        global Integer statusCode {get;set;}
        global String data {get;set;}
        global String message {get;set;}
    }

}
