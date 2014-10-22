var appModule = angular.module('logged', []);


function LoggedController($scope,$http,$location) {
    $http.get('/user/1').
    success(function(data,status,headers,config){
	$scope.current_user = data;
    });
    $scope.logged_users = [1,2,3,4];
    $scope.createGame = function(){
	$http.post('/logged/1/create').
	    success(function(data){
		$scope.created_game = 'true';
	    });
    };
	
};

