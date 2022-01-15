//SPDX-License-Identifier:MIT;

pragma solidity ^0.6.0 ;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

//inheritance
contract RandomnessinDeterministicBlockchain is VRFConsumerBase {

    //identifies the specific node of oracle network
    bytes32 public keyHash;

    //link token needed to request data from oracle
    uint256 public  linkFees;

    //rnadomness given as response from oracle
    uint256 public randomOutcome;

    // we are using VRFConsumerBase constructor
    //contructor takes two parameters
    //VRFCoordinator , LinkToken
    //VRFCordinator is a smart contract that verifies the truth of randomness
    constructor( ) VRFConsumerBase(0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9,0xa36085F69e2889c224210F603D836748e7dC0088){
         
            //KeyHash of oracle node
            keyHash = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;
            linkFees = 0.1 * 10 ** 18;
        }
    
    modifier validLinkbalance {
        require (LINK.balanceOf(address(this))>=linkFees,'Not enough LINK balance');
        _;
    }
    //getter
    function getRandomness()public  validLinkbalance returns(bytes32 requestID){
        return requestRandomness(keyHash,linkFees);
    }

    //callback function used by VRF cordinator to verify randomness
    function fulfillRandomness(bytes32 requestID,uint256 _randomness) internal override {
        randomOutcome=_randomness;
    }

}
