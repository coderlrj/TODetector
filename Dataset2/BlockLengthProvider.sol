pragma solidity ^0.5.0;

contract BlockLengthProvider {
    uint256 private _surveyDurationInBlocks;

    //Survey duration is passed as parameter. So it is more versatile and re-usabe
    constructor(uint256 surveyDurationInBlocks) public {
        _surveyDurationInBlocks = surveyDurationInBlocks;
    }

    function getMinimumBlockNumberForSurvey() public view returns(uint256) {
        return _surveyDurationInBlocks;
    }
}