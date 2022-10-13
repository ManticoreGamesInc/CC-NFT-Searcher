<div align="center">

# NFT Searcher

[![Build Status](https://github.com/ManticoreGamesInc/CC-NFT-Searcher/workflows/CI/badge.svg)](https://github.com/ManticoreGamesInc/CC-NFT-Searcher/actions/workflows/ci.yml?query=workflow%3ACI%29)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/ManticoreGamesInc/CC-NFT-Searcher?style=plastic)

![Preview](/Screenshots/nftsearcher.png)

</div>

## Finding the Component

This component can be found under the **CoreAcademy** account on Community Content.

## Overview

NFT Searcher is a component that allows users to search for a specific NFT and display it on an image.
                                                                   
The user needs to provide a contract address and token id using the UI Text Entry Box component. Other users should see the most recent successful NFT searched for.  

## Setup

Drag and drop the NFT Searcher template into the Hierarchy.

Preview the project and interact with the portrait trigger.

Add a NFT's contract address and token id into the UI Text Entry Box.

Press submit and the NFT image should appear if done correctly.

## How to use this Template
The root object of the template has 3 custom properties.

- ContractAddress

The contract address of a default NFT to display.
If empty, there will be no default NFT displayed.

- TokenId

The token id of a default NFT to display.
If empty, there will be no default NFT displayed.

- DisplayName

Should the name of the NFT be displayed on top of the NFT image.
