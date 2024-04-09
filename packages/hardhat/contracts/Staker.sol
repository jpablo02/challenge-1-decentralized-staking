// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;

  constructor(address exampleExternalContractAddress) {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  uint256 public constant threshold = 1 ether;
  uint256 public deadline = block.timestamp + 30 seconds;



  mapping ( address => uint256 ) public balance;

  event Stake(address, uint256);

  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  // (Make sure to add a `Stake(address,uint256)` event and emit it for the frontend `All Stakings` tab to display)

  function stake () payable public{
    require(msg.value > 0, "Usted no tiene fondos suficientes");
    balance[msg.sender] += msg.value;
    emit Stake (msg.sender,msg.value);
    }

    function execute() public{ 
      require (block.timestamp >= deadline ,"Aun no es tiempo de liberacion");

      if (address(this).balance >= threshold) {
        exampleExternalContract.complete{value:address(this).balance}();

      }else {
        
      }


    }

  }


  // After some `deadline` allow anyone to call an `execute()` function
  // If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`


  // If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balance


  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend


  // Add the `receive()` special function that receives eth and calls stake()


