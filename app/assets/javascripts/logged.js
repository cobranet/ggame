var appModule = angular.module('logged', []);

appModule.config([
  "$httpProvider", function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

function LoggedController($scope,$http,$location) {
    
  
    url = $location.absUrl();
    $scope.user_id = url.split('/')[4];
    url = '/logged/' + $scope.user_id
    $scope.joinGame= function(id) {
	$http.post(url + '/join/', {ginvid: id}).
	    success(function(data){
		$scope.state = data;
	    });};
    
    $scope.getState= function(){
	$http.get(url + '/state').
	    success(function(data){
		$scope.state = data;
	    });};
	
    $scope.createGame = function(){
	$http.post(url+'/create').
	    success(function(data){
		$scope.state = data;
	    });
    };
    
    $scope.cancelGame = function(gameinv_id){
	$http.post(url+'/cancel',{gameinv_id: gameinv_id} ).
	    success(function(data){
		$scope.state = data;
	    });
    };

    $scope.cancelWaiting = function(gap){

	$http.post(url+'/cancel_waiting',{gameapp:gap}).
	    success(function(data){
		$scope.state = data;
	    });
    };
    
    $scope.acceptPlayer = function (gap){
	$http.post(url+'/accept_player',{gameapp:gap}).
	    success(function(data){
		$scope.state = data;
	    });
    };

    $scope.rejectPlayer = function (gap){
	$http.post(url+'/reject_player',{gameapp:gap}).
	    success(function(data){
		$scope.state = data;
	    });
    };
	
    $scope.getState();
    $scope.client = new Faye.Client('/faye');
    $scope.client.subscribe('/chat/' + $scope.user_id, function(message) {
	$scope.getState();
    });
    $scope.client.subscribe('/allwaiting', function(message) {
	$scope.getState();
    });

};

