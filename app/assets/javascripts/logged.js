var appModule = angular.module('logged', []);

function LoggedController($scope) {
    $scope.user = { name: "Bratislav Petrovic",
		    image: "nekiimg" }; 
    $scope.logged_users = [1,2,3,4];
};

