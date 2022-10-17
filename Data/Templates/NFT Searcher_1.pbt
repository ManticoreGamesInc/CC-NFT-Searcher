Assets {
  Id: 15128894864013200850
  Name: "NFT Searcher"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 5456623627402495640
      Objects {
        Id: 5456623627402495640
        Name: "TemplateBundleDummy"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        Folder {
          BundleDummy {
            ReferencedAssets {
              Id: 736360303936294653
            }
            ReferencedAssets {
              Id: 6702266276352956128
            }
            ReferencedAssets {
              Id: 6235135006761033528
            }
            ReferencedAssets {
              Id: 3456202429475588989
            }
            ReferencedAssets {
              Id: 15669355375314984524
            }
            ReferencedAssets {
              Id: 17739455570673247523
            }
          }
        }
      }
    }
    Assets {
      Id: 17739455570673247523
      Name: "NFTSearcher_Server"
      PlatformAssetType: 3
      TextAsset {
        Text: "local COMPONENT_ROOT = script:GetCustomProperty(\"ComponentRoot\"):WaitForObject()\r\n\r\nEvents.Connect(COMPONENT_ROOT.id .. \".NewToken\", function(contractAddress, tokenId)\r\n\tscript:SetCustomProperty(\"CurrentNFT\", contractAddress .. \"/\" .. tokenId)\r\nend)\r\n\r\nEvents.ConnectForPlayer(COMPONENT_ROOT.id .. \".LockCrouch\", function(player)\r\n\tplayer.isCrouchEnabled = false\r\nend)\r\n\r\nEvents.ConnectForPlayer(COMPONENT_ROOT.id .. \".UnlockCrouch\", function(player)\r\n\tplayer.isCrouchEnabled = true\r\nend)"
        CustomParameters {
        }
      }
    }
    Assets {
      Id: 15669355375314984524
      Name: "NFTSearcher_README"
      PlatformAssetType: 3
      TextAsset {
        Text: "--[[\r\n\r\n  _   _ ______ _______    _____                     _               \r\n | \\ | |  ____|__   __|  / ____|                   | |              \r\n |  \\| | |__     | |    | (___   ___  __ _ _ __ ___| |__   ___ _ __ \r\n | . ` |  __|    | |     \\___ \\ / _ \\/ _` | \'__/ __| \'_ \\ / _ \\ \'__|\r\n | |\\  | |       | |     ____) |  __/ (_| | | | (__| | | |  __/ |   \r\n |_| \\_|_|       |_|    |_____/ \\___|\\__,_|_|  \\___|_| |_|\\___|_|   \r\n                                                                    \r\nNFT Searcher is a component that allows users to search for a\r\nspecific NFT and display it on an image.\r\n                                                                   \r\nThe user needs to provide a contract address and token id\r\nusing the UI Text Entry Box component. Other users should\r\nsee the most recent succesful NFT searched for.                                                                 \r\n\r\n=====\r\nSetup\r\n=====\r\n\r\nDrag and drop the NFT Searcher template into the Hierarchy.\r\n\r\nPreview the project and interact with the portrait trigger.\r\n\r\nAdd a NFT\'s contract address and token id into the UI Text Entry Box.\r\n\r\nPress submit and the NFT image should appear if done correctly.\r\n\r\n==========\r\nHow to Use\r\n==========\r\n\r\nThe root object of the template has 3 custom properties.\r\n\r\n- ContractAddress\r\n\r\nThe contract address of a default NFT to display.\r\nIf empty, there will be no default NFT displayed.\r\n\r\n- TokenId\r\n\r\nThe token id of a default NFT to display.\r\nIf empty, there will be no default NFT displayed.\r\n\r\n- DisplayName\r\n\r\nShould the name of the NFT be displayed on top of the NFT image.\r\n\r\n]]"
        CustomParameters {
        }
      }
    }
    Assets {
      Id: 3456202429475588989
      Name: "NFTSearcher_Client"
      PlatformAssetType: 3
      TextAsset {
        Text: "local COMPONENT_ROOT = script:GetCustomProperty(\"ComponentRoot\"):WaitForObject()\r\nlocal SERVER_SCRIPT = script:GetCustomProperty(\"ServerScript\"):WaitForObject()\r\nlocal PICTURE = script:GetCustomProperty(\"Picture\"):WaitForObject()\r\nlocal INFO_BG = script:GetCustomProperty(\"InfoBG\"):WaitForObject()\r\nlocal INFO = script:GetCustomProperty(\"Info\"):WaitForObject()\r\nlocal TRIGGER = script:GetCustomProperty(\"Trigger\"):WaitForObject()\r\nlocal SCREEN_UICONTAINER = script:GetCustomProperty(\"ScreenUIContainer\"):WaitForObject()\r\nlocal CONTRACT_ADDRESS_ENTRY = script:GetCustomProperty(\"ContractAddressEntry\"):WaitForObject()\r\nlocal TOKEN_ID_ENTRY = script:GetCustomProperty(\"TokenIdEntry\"):WaitForObject()\r\nlocal SEARCH_BUTTON = script:GetCustomProperty(\"SearchButton\"):WaitForObject()\r\nlocal CLOSE_BUTTON = script:GetCustomProperty(\"CloseButton\"):WaitForObject()\r\n\r\nlocal DEFAULT_CONTRACT_ADDRESS = COMPONENT_ROOT:GetCustomProperty(\"ContractAddress\")\r\nlocal DEFAULT_TOKEN_ID = COMPONENT_ROOT:GetCustomProperty(\"TokenId\")\r\nlocal DISPLAY_NAME = COMPONENT_ROOT:GetCustomProperty(\"DisplayName\")\r\n\r\nlocal contractAddress = \"\"\r\nlocal tokenId = \"\"\r\n\r\nlocal LOCAL_PLAYER = Game.GetLocalPlayer()\r\n\r\nINFO_BG.visibility = DISPLAY_NAME and Visibility.FORCE_ON or Visibility.FORCE_OFF\r\n\r\nlocal function UpdateNewToken(newContract, newId)\r\n\tTask.Spawn(function()\r\n\t\tlocal token, status, msg = Blockchain.GetToken(newContract, newId)\r\n\t\tif status == BlockchainTokenResultCode.SUCCESS then\r\n\t\t\tcontractAddress = newContract\r\n\t\t\ttokenId = newId\r\n\t\t\tPICTURE:SetBlockchainToken(token)\r\n\t\t\tINFO.text = token.name\r\n\t\telse\r\n\t\t\twarn(msg)\r\n\t\tend\r\n\tend)\r\nend\r\n\r\nlocal function IsValidNewToken(newContract, newId)\r\n\tif newContract == nil or newId == nil then\r\n\t\treturn false\r\n\tend\r\n\treturn newContract ~= \"\" and newId ~= \"\" and (newContract ~= contractAddress or newId ~= tokenId)\r\nend\r\n\r\nlocal function CheckForTokenUpdate()\r\n\tlocal CURRENT_NFT = SERVER_SCRIPT:GetCustomProperty(\"CurrentNFT\")\r\n\tlocal CONTRACT_ADDRESS, TOKEN_ID = CoreString.Split(CURRENT_NFT, {\r\n        delimiters = {\"/\"}, \r\n        removeEmptyResults = true\r\n    })\r\n\tif IsValidNewToken(CONTRACT_ADDRESS, TOKEN_ID) then\r\n\t\tUpdateNewToken(CONTRACT_ADDRESS, TOKEN_ID)\r\n\telseif IsValidNewToken(DEFAULT_CONTRACT_ADDRESS, DEFAULT_TOKEN_ID) then\r\n\t\tUpdateNewToken(DEFAULT_CONTRACT_ADDRESS, DEFAULT_TOKEN_ID)\r\n\tend\r\nend\r\n\r\n\r\nlocal function OpenScreenUI()\r\n\tEvents.BroadcastToServer(COMPONENT_ROOT.id .. \".LockCrouch\")\r\n\tSCREEN_UICONTAINER.visibility = Visibility.FORCE_ON\r\n\tUI.SetCursorVisible(true)\r\n\tUI.SetCanCursorInteractWithUI(true)\r\n\tif contractAddress ~= \"\" then\r\n\t\tCONTRACT_ADDRESS_ENTRY.text = contractAddress\r\n\tend\r\n\tif tokenId ~= \"\" then\r\n\t\tTOKEN_ID_ENTRY.text = tokenId\r\n\tend\r\nend\r\n\r\nlocal function CloseScreenUI()\r\n\tEvents.BroadcastToServer(COMPONENT_ROOT.id .. \".UnlockCrouch\")\r\n\tSCREEN_UICONTAINER.visibility = Visibility.FORCE_OFF\r\n\tUI.SetCursorVisible(false)\r\n\tUI.SetCanCursorInteractWithUI(false)\r\n\tTRIGGER.isInteractable = TRIGGER:IsOverlapping(LOCAL_PLAYER)\r\nend\r\n\r\nlocal function OnBeginOverlap(trigger, other)\r\n\tif other == LOCAL_PLAYER then\r\n\t\tTRIGGER.isInteractable = true\r\n\tend\r\nend\r\n\r\nlocal function OnEndOverlap(trigger, other)\r\n\tif other == LOCAL_PLAYER then\r\n\t\tCloseScreenUI()\r\n\tend\r\nend\r\n\r\nlocal function OnInteracted(trigger, other)\r\n\tif other == LOCAL_PLAYER then\r\n\t\tOpenScreenUI()\r\n\t\tTRIGGER.isInteractable = false\r\n\tend\r\nend\r\n\r\nlocal function OnSearch()\r\n\tif IsValidNewToken(CONTRACT_ADDRESS_ENTRY.text, TOKEN_ID_ENTRY.text) then\r\n\t\tEvents.BroadcastToServer(COMPONENT_ROOT.id .. \".NewToken\", CONTRACT_ADDRESS_ENTRY.text, TOKEN_ID_ENTRY.text)\r\n\tend\r\n\tCloseScreenUI()\r\nend\r\n\r\nlocal function OnPropChange(owner, prop)\r\n\tif prop == \"CurrentNFT\" then\r\n\t\tCheckForTokenUpdate()\r\n\tend\r\nend\r\n\r\nTRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)\r\nTRIGGER.endOverlapEvent:Connect(OnEndOverlap)\r\nTRIGGER.interactedEvent:Connect(OnInteracted)\r\n\r\nSEARCH_BUTTON.clickedEvent:Connect(OnSearch)\r\n\r\nCLOSE_BUTTON.clickedEvent:Connect(CloseScreenUI)\r\n\r\nSERVER_SCRIPT.customPropertyChangedEvent:Connect(OnPropChange)\r\n\r\nCloseScreenUI()\r\nCheckForTokenUpdate()"
        CustomParameters {
        }
      }
    }
    Assets {
      Id: 6235135006761033528
      Name: "NFT Searcher"
      PlatformAssetType: 5
      TemplateAsset {
        ObjectBlock {
          RootId: 12759159628729332843
          Objects {
            Id: 12759159628729332843
            Name: "NFT Searcher"
            Transform {
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 4781671109827199097
            ChildIds: 12147998264968328611
            ChildIds: 8523460820212879581
            ChildIds: 12564378733304393732
            ChildIds: 17522925056153677693
            UnregisteredParameters {
              Overrides {
                Name: "cs:ContractAddress"
                String: ""
              }
              Overrides {
                Name: "cs:TokenId"
                String: ""
              }
              Overrides {
                Name: "cs:DisplayName"
                Bool: true
              }
              Overrides {
                Name: "cs:ContractAddress:tooltip"
                String: "The contract address of the deafult NFT."
              }
              Overrides {
                Name: "cs:TokenId:tooltip"
                String: "The Token Id of the default NFT."
              }
              Overrides {
                Name: "cs:DisplayName:tooltip"
                String: "Should the token name be displayed on the image."
              }
            }
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Folder {
              IsGroup: true
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 12147998264968328611
            Name: "README"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 12759159628729332843
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Script {
              ScriptAsset {
                Id: 15669355375314984524
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 8523460820212879581
            Name: "NFTSearcher_Server"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 12759159628729332843
            UnregisteredParameters {
              Overrides {
                Name: "cs:ComponentRoot"
                ObjectReference {
                  SubObjectId: 12759159628729332843
                }
              }
              Overrides {
                Name: "cs:CurrentNFT"
                String: ""
              }
              Overrides {
                Name: "cs:CurrentNFT:isrep"
                Bool: true
              }
            }
            WantsNetworking: true
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Script {
              ScriptAsset {
                Id: 17739455570673247523
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 12564378733304393732
            Name: "Frame"
            Transform {
              Location {
                X: -2.82736135
                Y: -4.76837158e-07
                Z: 250
              }
              Rotation {
                Pitch: 90
                Yaw: 180
                Roll: 180
              }
              Scale {
                X: 2.09091187
                Y: 2.09091187
                Z: 0.161310807
              }
            }
            ParentId: 12759159628729332843
            UnregisteredParameters {
              Overrides {
                Name: "ma:Shared_BaseMaterial:id"
                AssetReference {
                  Id: 6328005888333410420
                }
              }
              Overrides {
                Name: "ma:Shared_BaseMaterial:smart"
                Bool: false
              }
            }
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            CoreMesh {
              MeshAsset {
                Id: 3118815666199242725
              }
              Teams {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              DisableCastShadows: true
              StaticMesh {
                Physics {
                  Mass: 100
                  LinearDamping: 0.01
                }
                BoundsScale: 1
              }
            }
            Relevance {
              Value: "mc:eproxyrelevance:critical"
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 17522925056153677693
            Name: "Client"
            Transform {
              Location {
                Z: 250
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 12759159628729332843
            ChildIds: 159869855772923035
            ChildIds: 10872480797136489482
            ChildIds: 9381166776209284672
            ChildIds: 11750418058192820817
            Collidable_v2 {
              Value: "mc:ecollisionsetting:forceoff"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:forceoff"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            NetworkContext {
              MinDetailLevel {
                Value: "mc:edetaillevel:low"
              }
              MaxDetailLevel {
                Value: "mc:edetaillevel:ultra"
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 159869855772923035
            Name: "NFTSearcher_Client"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17522925056153677693
            UnregisteredParameters {
              Overrides {
                Name: "cs:ComponentRoot"
                ObjectReference {
                  SubObjectId: 12759159628729332843
                }
              }
              Overrides {
                Name: "cs:ServerScript"
                ObjectReference {
                  SubObjectId: 8523460820212879581
                }
              }
              Overrides {
                Name: "cs:Picture"
                ObjectReference {
                  SubObjectId: 3030470521040940474
                }
              }
              Overrides {
                Name: "cs:InfoBG"
                ObjectReference {
                  SubObjectId: 15770827048616554364
                }
              }
              Overrides {
                Name: "cs:Info"
                ObjectReference {
                  SubObjectId: 11358146742528198329
                }
              }
              Overrides {
                Name: "cs:Trigger"
                ObjectReference {
                  SubObjectId: 11750418058192820817
                }
              }
              Overrides {
                Name: "cs:ScreenUIContainer"
                ObjectReference {
                  SubObjectId: 9381166776209284672
                }
              }
              Overrides {
                Name: "cs:ContractAddressEntry"
                ObjectReference {
                  SubObjectId: 13348354525639016617
                }
              }
              Overrides {
                Name: "cs:TokenIdEntry"
                ObjectReference {
                  SubObjectId: 9508077666513783279
                }
              }
              Overrides {
                Name: "cs:SearchButton"
                ObjectReference {
                  SubObjectId: 9510706857645219444
                }
              }
              Overrides {
                Name: "cs:CloseButton"
                ObjectReference {
                  SubObjectId: 4978414367293648870
                }
              }
            }
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Script {
              ScriptAsset {
                Id: 3456202429475588989
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 10872480797136489482
            Name: "World UI Container"
            Transform {
              Location {
                X: -8.04736
                Y: -1.90734863e-06
              }
              Rotation {
                Yaw: 180
              }
              Scale {
                X: 0.191999808
                Y: 0.191999808
                Z: 0.191999808
              }
            }
            ParentId: 17522925056153677693
            ChildIds: 3030470521040940474
            ChildIds: 15770827048616554364
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:forceon"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              Canvas {
                ContentType {
                  Value: "mc:ecanvascontenttype:dynamic"
                }
                Opacity: 1
                CanvasWorldSize {
                  X: 1024
                  Y: 1024
                }
                RedrawTime: 30
                UseSafeZoneAdjustment: true
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 3030470521040940474
            Name: "Picture"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 10872480797136489482
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 200
              Height: 200
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              UseParentWidth: true
              UseParentHeight: true
              Image {
                Brush {
                }
                Color {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                TeamSettings {
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
                ScreenshotIndex: 1
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 15770827048616554364
            Name: "Info BG"
            Transform {
              Location {
                X: 2437.48853
                Y: -3582.40234
                Z: -1220.96375
              }
              Rotation {
                Yaw: 89.9998779
              }
              Scale {
                X: 5.20833874
                Y: 5.20833874
                Z: 5.20833874
              }
            }
            ParentId: 10872480797136489482
            ChildIds: 11358146742528198329
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 200
              Height: 125
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              UseParentWidth: true
              Image {
                Brush {
                }
                Color {
                  A: 0.854000032
                }
                TeamSettings {
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
                ScreenshotIndex: 1
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:bottomcenter"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:bottomcenter"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 11358146742528198329
            Name: "Info"
            Transform {
              Location {
                X: -0.000610350573
                Y: -0.00125122117
              }
              Rotation {
                Yaw: 4.43962199e-05
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 15770827048616554364
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 200
              Height: 60
              UIY: 4
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              UseParentWidth: true
              Text {
                Label: "NFT Searcher"
                Color {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Size: 75
                Justification {
                  Value: "mc:etextjustify:center"
                }
                AutoWrapText: true
                Font {
                  Id: 3081743918018300983
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
                OutlineColor {
                  A: 1
                }
                OutlineSize: 4
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:middlecenter"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:middlecenter"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 9381166776209284672
            Name: "Screen UI Container"
            Transform {
              Location {
                X: -309.379425
                Y: 363.65509
                Z: -234.424805
              }
              Rotation {
                Yaw: -90.0000534
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17522925056153677693
            ChildIds: 10825756105788663126
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:forceoff"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              Canvas {
                ContentType {
                  Value: "mc:ecanvascontenttype:dynamic"
                }
                Opacity: 1
                IsHUD: true
                CanvasWorldSize {
                  X: 1024
                  Y: 1024
                }
                RedrawTime: 30
                UseSafeZoneAdjustment: true
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 10825756105788663126
            Name: "UI Panel"
            Transform {
              Location {
                X: 3.05175781e-05
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 9381166776209284672
            ChildIds: 17886920655351784774
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 800
              Height: 500
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              Panel {
                Opacity: 1
                OpacityMaskBrush {
                  Id: 841534158063459245
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:middlecenter"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:middlecenter"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 17886920655351784774
            Name: "BG"
            Transform {
              Location {
                X: 3.05175781e-05
                Y: 3.05175781e-05
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 10825756105788663126
            ChildIds: 13903255902007965790
            ChildIds: 13348354525639016617
            ChildIds: 1505468187429919681
            ChildIds: 9508077666513783279
            ChildIds: 9510706857645219444
            ChildIds: 4978414367293648870
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 200
              Height: 200
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              UseParentWidth: true
              UseParentHeight: true
              Image {
                Brush {
                }
                Color {
                  A: 1
                }
                TeamSettings {
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
                ScreenshotIndex: 1
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 13903255902007965790
            Name: "Contract Address"
            Transform {
              Location {
                X: 3.05175781e-05
                Y: 3.05175781e-05
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17886920655351784774
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 200
              Height: 100
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              UseParentWidth: true
              Text {
                Label: "Contract Address"
                Color {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Size: 60
                Justification {
                  Value: "mc:etextjustify:center"
                }
                AutoWrapText: true
                Font {
                  Id: 3081743918018300983
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
                OutlineColor {
                  A: 1
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 13348354525639016617
            Name: "Contract Address Entry"
            Transform {
              Location {
                X: 3.05175781e-05
                Y: 3.05175781e-05
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17886920655351784774
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 750
              Height: 100
              UIX: 25
              UIY: 100
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              IsHittable: true
              EditableText {
                Prompt: "Type Here"
                Color {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Font {
                  Id: 3081743918018300983
                }
                OutlineColor {
                  A: 1
                }
                Size: 50
                BackgroundColor {
                  R: 0.206000015
                  G: 0.206000015
                  B: 0.206000015
                  A: 1
                }
                HoveredColor {
                  R: 0.010329823
                  G: 0.0129830325
                  B: 0.0202885624
                  A: 1
                }
                FocusedColor {
                  R: 0.010329823
                  G: 0.0129830325
                  B: 0.0202885624
                  A: 1
                }
                DisabledColor {
                  R: 0.0193823613
                  G: 0.0221738853
                  B: 0.0318960324
                  A: 1
                }
                SelectionHighlightColor {
                  R: 0.00856812578
                  G: 0.361306787
                  B: 0.799102724
                  A: 1
                }
                IsEnabled: true
                Brush {
                  Id: 841534158063459245
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 1505468187429919681
            Name: "Token Id"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17886920655351784774
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 200
              Height: 100
              UIY: 200
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              UseParentWidth: true
              Text {
                Label: "Token Id"
                Color {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Size: 60
                Justification {
                  Value: "mc:etextjustify:center"
                }
                AutoWrapText: true
                Font {
                  Id: 3081743918018300983
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
                OutlineColor {
                  A: 1
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 9508077666513783279
            Name: "Token Id Entry"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17886920655351784774
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 750
              Height: 100
              UIX: 25
              UIY: 300
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              IsHittable: true
              EditableText {
                Prompt: "Type Here"
                Color {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Font {
                  Id: 3081743918018300983
                }
                OutlineColor {
                  A: 1
                }
                Size: 50
                BackgroundColor {
                  R: 0.206000015
                  G: 0.206000015
                  B: 0.206000015
                  A: 1
                }
                HoveredColor {
                  R: 0.010329823
                  G: 0.0129830325
                  B: 0.0202885624
                  A: 1
                }
                FocusedColor {
                  R: 0.010329823
                  G: 0.0129830325
                  B: 0.0202885624
                  A: 1
                }
                DisabledColor {
                  R: 0.0193823613
                  G: 0.0221738853
                  B: 0.0318960324
                  A: 1
                }
                SelectionHighlightColor {
                  R: 0.00856812578
                  G: 0.361306787
                  B: 0.799102724
                  A: 1
                }
                IsEnabled: true
                Brush {
                  Id: 841534158063459245
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 9510706857645219444
            Name: "Search Button"
            Transform {
              Location {
                X: 3.05175781e-05
                Y: 3.05175781e-05
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17886920655351784774
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 300
              Height: 80
              UIY: 410
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              IsHittable: true
              Button {
                Label: "Search"
                FontColor {
                  A: 1
                }
                FontSize: 60
                ButtonColor {
                  R: 0.0431124829
                  G: 0.929999948
                  A: 1
                }
                HoveredColor {
                  G: 0.603333235
                  B: 0.0519427359
                  A: 1
                }
                PressedColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                DisabledColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Brush {
                  Id: 841534158063459245
                }
                IsButtonEnabled: true
                ClickMode {
                  Value: "mc:ebuttonclickmode:default"
                }
                Font {
                  Id: 3081743918018300983
                }
                Justification {
                  Value: "mc:etextjustify:center"
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topcenter"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topcenter"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 4978414367293648870
            Name: "Close Button"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17886920655351784774
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 50
              Height: 50
              UIX: -25
              UIY: 25
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              IsHittable: true
              Button {
                FontColor {
                  A: 1
                }
                FontSize: 60
                ButtonColor {
                  R: 1
                  G: 0.00999999
                  B: 0.00999999
                  A: 1
                }
                HoveredColor {
                  R: 0.551
                  A: 1
                }
                PressedColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                DisabledColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Brush {
                  Id: 7385661824659641961
                }
                IsButtonEnabled: true
                ClickMode {
                  Value: "mc:ebuttonclickmode:default"
                }
                Font {
                  Id: 3081743918018300983
                }
                Justification {
                  Value: "mc:etextjustify:center"
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topright"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topright"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 11750418058192820817
            Name: "Trigger"
            Transform {
              Location {
                X: -137.922714
                Y: 0.000137329102
                Z: -72.2369537
              }
              Rotation {
                Yaw: -90.000061
              }
              Scale {
                X: 3.30981898
                Y: 2.47997451
                Z: 3.17007732
              }
            }
            ParentId: 17522925056153677693
            Collidable_v2 {
              Value: "mc:ecollisionsetting:forceon"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Trigger {
              Interactable: true
              InteractionLabel: "Search for NFT"
              TeamSettings {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              TriggerShape_v2 {
                Value: "mc:etriggershape:box"
              }
              InteractionTemplate {
              }
              BreadcrumbTemplate {
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
        }
        PrimaryAssetId {
          AssetType: "None"
          AssetId: "None"
        }
      }
    }
    Assets {
      Id: 7385661824659641961
      Name: "Icon Close"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "Icon_Close"
      }
    }
    Assets {
      Id: 3081743918018300983
      Name: "Teko Bold"
      PlatformAssetType: 28
      PrimaryAsset {
        AssetType: "FontAssetRef"
        AssetId: "TekoBold_ref"
      }
    }
    Assets {
      Id: 6328005888333410420
      Name: "Wood Planks"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mi_wood_planks_dark_001_uv"
      }
    }
    Assets {
      Id: 3118815666199242725
      Name: "Container - Square Thin 01"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_container_square_thin_ref"
      }
    }
    Assets {
      Id: 6702266276352956128
      Name: "Example"
      PlatformAssetType: 5
      TemplateAsset {
        ObjectBlock {
          RootId: 653126373662835780
          Objects {
            Id: 653126373662835780
            Name: "Example"
            Transform {
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 4781671109827199097
            ChildIds: 15522705106380089895
            ChildIds: 16371231310396288016
            ChildIds: 8555138092450851985
            ChildIds: 16149860227258165569
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Folder {
              IsGroup: true
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 15522705106380089895
            Name: "NFT Searcher"
            Transform {
              Location {
                X: 500
                Y: 500
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 653126373662835780
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            TemplateInstance {
              ParameterOverrideMap {
                key: 12759159628729332843
                value {
                  Overrides {
                    Name: "Name"
                    String: "NFT Searcher - CryptoPunk Example"
                  }
                  Overrides {
                    Name: "Position"
                    Vector {
                      Y: -500
                    }
                  }
                  Overrides {
                    Name: "Rotation"
                    Rotator {
                    }
                  }
                  Overrides {
                    Name: "Scale"
                    Vector {
                      X: 1
                      Y: 1
                      Z: 1
                    }
                  }
                  Overrides {
                    Name: "cs:ContractAddress"
                    String: "0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb"
                  }
                  Overrides {
                    Name: "cs:TokenId"
                    String: "1"
                  }
                }
              }
              TemplateAsset {
                Id: 6235135006761033528
              }
            }
          }
          Objects {
            Id: 16371231310396288016
            Name: "NFT Searcher"
            Transform {
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 653126373662835780
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            TemplateInstance {
              ParameterOverrideMap {
                key: 12759159628729332843
                value {
                  Overrides {
                    Name: "Name"
                    String: "NFT Searcher - MekaVerse Example"
                  }
                  Overrides {
                    Name: "Position"
                    Vector {
                    }
                  }
                  Overrides {
                    Name: "Rotation"
                    Rotator {
                    }
                  }
                  Overrides {
                    Name: "cs:ContractAddress"
                    String: "0x9a534628b4062e123ce7ee2222ec20b86e16ca8f"
                  }
                  Overrides {
                    Name: "cs:TokenId"
                    String: "1"
                  }
                  Overrides {
                    Name: "cs:DisplayName"
                    Bool: false
                  }
                  Overrides {
                    Name: "Scale"
                    Vector {
                      X: 1
                      Y: 1
                      Z: 1
                    }
                  }
                }
              }
              TemplateAsset {
                Id: 6235135006761033528
              }
            }
          }
          Objects {
            Id: 8555138092450851985
            Name: "NFT Searcher"
            Transform {
              Location {
                X: 500
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 653126373662835780
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            TemplateInstance {
              ParameterOverrideMap {
                key: 12759159628729332843
                value {
                  Overrides {
                    Name: "Name"
                    String: "NFT Searcher - Bored Ape Example"
                  }
                  Overrides {
                    Name: "Position"
                    Vector {
                      Y: 500
                    }
                  }
                  Overrides {
                    Name: "Rotation"
                    Rotator {
                    }
                  }
                  Overrides {
                    Name: "Scale"
                    Vector {
                      X: 1
                      Y: 1
                      Z: 1
                    }
                  }
                  Overrides {
                    Name: "cs:ContractAddress"
                    String: "0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d"
                  }
                  Overrides {
                    Name: "cs:TokenId"
                    String: "1"
                  }
                }
              }
              TemplateAsset {
                Id: 6235135006761033528
              }
            }
          }
          Objects {
            Id: 16149860227258165569
            Name: "Cube - Bottom-Aligned"
            Transform {
              Location {
                X: 24.6717529
                Y: -6.69404602
              }
              Rotation {
              }
              Scale {
                X: 0.551359653
                Y: 12.653779
                Z: 3.59947
              }
            }
            ParentId: 653126373662835780
            UnregisteredParameters {
              Overrides {
                Name: "ma:Shared_BaseMaterial:id"
                AssetReference {
                  Id: 11951506208073665883
                }
              }
            }
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            CoreMesh {
              MeshAsset {
                Id: 8255349158049122666
              }
              Teams {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              StaticMesh {
                Physics {
                  Mass: 100
                  LinearDamping: 0.01
                }
                BoundsScale: 1
              }
            }
            Relevance {
              Value: "mc:eproxyrelevance:critical"
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
        }
        PrimaryAssetId {
          AssetType: "None"
          AssetId: "None"
        }
      }
    }
    Assets {
      Id: 11951506208073665883
      Name: "Brick Red Old 01"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mi_brick_red_old_001_uv"
      }
    }
    Assets {
      Id: 8255349158049122666
      Name: "Cube - Bottom-Aligned"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_cube_001"
      }
    }
    Assets {
      Id: 736360303936294653
      Name: "Default Bindings"
      PlatformAssetType: 29
      BindingSetAsset {
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:spacebar"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:a"
              }
            }
          }
          Action: "Jump"
          Description: "Make the character jump."
          CoreBehavior {
            Value: "mc:ecorebehavior:jump"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftcontrol"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:c"
              }
              Controller {
                Value: "mc:ebindinggamepad:b"
              }
            }
          }
          Action: "Crouch"
          Description: "Enter crouch mode."
          CoreBehavior {
            Value: "mc:ecorebehavior:crouch"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:g"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:dpadup"
              }
            }
          }
          Action: "Mount"
          Description: "Enter mount mode."
          CoreBehavior {
            Value: "mc:ecorebehavior:mount"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:f"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:x"
              }
            }
          }
          Action: "Interact"
          Description: "Interact with triggers."
          CoreBehavior {
            Value: "mc:ecorebehavior:interact"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:enter"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:none"
              }
            }
          }
          Action: "Chat"
          Description: "Opens chat dialog and social menu."
          CoreBehavior {
            Value: "mc:ecorebehavior:chat"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:tilde"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:middleclick"
              }
              Controller {
                Value: "mc:ebindinggamepad:view"
              }
            }
          }
          Action: "Slot Picker"
          Description: "Reopens last opened picker menu."
          CoreBehavior {
            Value: "mc:ecorebehavior:slotpicker"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:directional"
          }
          DirectionalBindingData {
            UpInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:w"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickup"
              }
            }
            LeftInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:a"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickleft"
              }
            }
            DownInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:s"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickdown"
              }
            }
            RightInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:d"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickright"
              }
            }
          }
          Action: "Move"
          Description: "Moves the character."
          CoreBehavior {
            Value: "mc:ecorebehavior:move"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:axis"
          }
          AxisBindingData {
            IncreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:spacebar"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:a"
              }
            }
            DecreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftcontrol"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:c"
              }
              Controller {
                Value: "mc:ebindinggamepad:b"
              }
            }
          }
          Action: "Move Vertically"
          Description: "Fly or swim vertically up and down."
          CoreBehavior {
            Value: "mc:ecorebehavior:movevertically"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:directional"
          }
          DirectionalBindingData {
            UpInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:mouseup"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightstickup"
              }
            }
            LeftInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:mouseleft"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightstickleft"
              }
            }
            DownInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:mousedown"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightstickdown"
              }
            }
            RightInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:mouseright"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightstickright"
              }
            }
          }
          Action: "Look"
          Description: "Controls the camera."
          CoreBehavior {
            Value: "mc:ecorebehavior:look"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:axis"
          }
          AxisBindingData {
            IncreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:scrolldown"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightbumper"
              }
            }
            DecreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:scrollup"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftbumper"
              }
            }
          }
          Action: "Zoom"
          Description: "Zoom in or out with the camera."
          CoreBehavior {
            Value: "mc:ecorebehavior:zoom"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftalt"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:none"
              }
            }
          }
          Action: "Push-to-Talk"
          Description: "Toggle voice chat mode."
          CoreBehavior {
            Value: "mc:ecorebehavior:pushtotalk"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftclick"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:righttrigger"
              }
            }
          }
          Action: "Shoot"
          Description: "Shoot ability of weapon or equipment."
          CoreBehavior {
            Value: "mc:ecorebehavior:weapon"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:rightclick"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:lefttrigger"
              }
            }
          }
          Action: "Aim"
          Description: "Weapon or equipment aiming."
          CoreBehavior {
            Value: "mc:ecorebehavior:weapon"
          }
          Networked: true
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:r"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:y"
              }
            }
          }
          Action: "Reload"
          Description: "Reload ability on weapons."
          CoreBehavior {
            Value: "mc:ecorebehavior:weapon"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftclick"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:x"
              }
            }
          }
          Action: "Attack"
          Description: "Attack ability for melee weapons or equipment."
          CoreBehavior {
            Value: "mc:ecorebehavior:equipment"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:w"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:righttrigger"
              }
            }
          }
          Action: "Vehicle Accelerate"
          Description: "When driving, accelerate forward."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehicleaccelerate"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:s"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:lefttrigger"
              }
            }
          }
          Action: "Vehicle Reverse"
          Description: "When driving, stop the vehicle and reverse."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehiclereverse"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:axis"
          }
          AxisBindingData {
            IncreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:d"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickright"
              }
            }
            DecreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:a"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickleft"
              }
            }
          }
          Action: "Vehicle Turn"
          Description: "When driving, turn the vehicle."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehicleturn"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:spacebar"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:b"
              }
            }
          }
          Action: "Vehicle Handbrake"
          Description: "When driving, apply the handbrake."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehiclehandbrake"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftclick"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:a"
              }
            }
          }
          Action: "Vehicle Shoot"
          Description: "Shoot ability on vehicle."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehicle"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:f"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:x"
              }
            }
          }
          Action: "Vehicle Exit"
          Description: "When driving, exit the vehicle."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehicleexit"
          }
          IsEnabledOnStart: true
        }
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  Marketplace {
    Id: "a818bfbbf86e462c8d51ef5d215d1b4b"
    OwnerAccountId: "bd602d5201b04b3fbf7be10f59c8f974"
    OwnerName: "CoreAcademy"
  }
  SerializationVersion: 119
}
IncludesAllDependencies: true
