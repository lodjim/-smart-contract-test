// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract StudentRegistry {
    
    struct Student {
        string name;
        uint256 studentId;
        bool enrolled;
    }

    mapping(address => Student) public students;
    
    event Registered(address indexed studentAddress, string name, uint256 studentId);
    
    event Graduated(address indexed studentAddress);
    
    modifier onlyRegistered(address _address) {
        require(students[_address].enrolled, "Student not registered");
        _;
    }
    
    modifier onlyNotRegistered(address _address) {
        require(!students[_address].enrolled, "Student already registered");
        _;
    }
    
    function register(string memory _name, uint256 _studentId) public onlyNotRegistered(msg.sender) {
        students[msg.sender] = Student({
            name: _name,
            studentId
            : _studentId,
            enrolled: true
        });
        emit Registered(msg.sender, _name, _studentId);
    }
    
    function graduate() public onlyRegistered(msg.sender) {
        students[msg.sender].enrolled = false;
        emit Graduated(msg.sender);
    }
}