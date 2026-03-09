{
    "d": {
        "actions": {
            "finish": [],
            "init": {
                "custom": "aura_env.spellList = {\n    [100780] = true,  -- Tiger Palm\n    [100784] = true,  -- Blackout Kick\n    [107428] = true,  -- Rising Sun Kick\n    [101545] = true,  -- Flying Serpent Kick\n    [113656] = true,  -- Fists of Fury\n    [101546] = true,  -- Spinning Crane Kick\n    [116847] = true,  -- Rushing Jade Wind\n    [152175] = true,  -- Whirling Dragon Punch\n    [115098] = true,  -- Chi Wave\n    [123986] = true,  -- Chi Burst\n    [117952] = true,  -- Crackling Jade Lightning\n    [392983] = true,  -- Strike of the Windlord\n    [322109] = true,  -- Touch of Death\n    [261947] = true,  -- Fist of the White Tiger\n    [322101] = true,  -- Expel Harm\n    [310454] = true,  -- Weapons of Order\n    [327104] = true,  -- Faeline Stomp\n    [325216] = true,  -- Bonedust Brew\n}\n\naura_env.ccCounter = 0\n\naura_env.exclamation1 = ''\n\naura_env.exclamations = {\n    [1] = \"\",\n    [3] = \"Yes!\",\n    [5] = \"Cool!\",\n    [7] = \"Good!\",\n    [13] = \"Dude!\",\n    [17] = \"Sweet!\",\n    [21] = \"Awesome!\",\n    [26] = \"Wonderful!\",\n    [31] = \"Viewtiful!\",\n    [37] = \"Excellent!\",\n    [43] = \"Stylish!\",\n    [50] = \"Fantastic!\",\n    [57] = \"Amazing!\",\n    [63] = \"Incredible!\",\n    [69] = \"Nice...\",\n    [75] = \"Mighty!\",\n    [82] = \"Marvelous!\",\n    [91] = \"Uncanny!\",\n    [101] = \"Crazy!\",\n    [111] = \"Galactic!\",\n    [201] = \"Unstoppable!\"\n}\n\n\n\n\n",
                "do_custom": true
            },
            "start": {
                "custom": "aura_env.ccCounter = 1",
                "do_custom": true,
                "do_sound": false,
                "sound": "Interface\\AddOns\\ElvUI\\media\\sounds\\warning.ogg"
            }
        },
        "alpha": 1,
        "anchorFrameType": "SCREEN",
        "anchorPoint": "CENTER",
        "animation": {
            "finish": {
                "alpha": 0,
                "colorA": 1,
                "colorB": 1,
                "colorG": 1,
                "colorR": 1,
                "duration_type": "seconds",
                "easeStrength": 3,
                "easeType": "none",
                "preset": "shrink",
                "rotate": 0,
                "scaleType": "custom",
                "scalex": 1,
                "scaley": 1,
                "type": "none",
                "use_scale": true,
                "x": 0,
                "y": 0
            },
            "main": {
                "alpha": 0,
                "alphaFunc": "function(progress, start, delta)\n      return start + (progress * delta)\n    end\n  ",
                "alphaType": "straight",
                "colorA": 1,
                "colorB": 0.94901960784314,
                "colorFunc": "\n\n",
                "colorG": 1,
                "colorR": 0.99607843137255,
                "colorType": "custom",
                "duration": "1",
                "duration_type": "seconds",
                "easeStrength": 1,
                "easeType": "none",
                "preset": "pulse",
                "rotate": 0,
                "scaleFunc": "function(progress, startX, startY, scaleX, scaleY)\n    return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\nend\n",
                "scaleType": "custom",
                "scalex": 1.4,
                "scaley": 0.1,
                "type": "custom",
                "use_alpha": false,
                "use_color": false,
                "use_scale": false,
                "x": 0,
                "y": 0
            },
            "start": {
                "duration_type": "seconds",
                "easeStrength": 3,
                "easeType": "none",
                "preset": "slidebottom",
                "scaleFunc": "",
                "scaleType": "custom",
                "type": "preset",
                "use_scale": false
            }
        },
        "authorOptions": [
            {
                "default": 1,
                "key": "option",
                "name": "Option 1",
                "type": "select",
                "useDesc": false,
                "values": [
                    "val1"
                ],
                "width": 1
            }
        ],
        "auto": true,
        "automaticWidth": "Auto",
        "color": [
            1,
            1,
            1,
            1
        ],
        "conditions": [
            {
                "changes": [
                    {
                        "property": "sound",
                        "value": {
                            "sound": "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\wilhelm.ogg",
                            "sound_channel": "SFX",
                            "sound_type": "Play"
                        }
                    }
                ],
                "check": {
                    "op": "==",
                    "trigger": 2,
                    "value": 1,
                    "variable": "same"
                }
            },
            {
                "changes": [
                    {
                        "property": "alpha",
                        "value": 0
                    },
                    {
                        "property": "color",
                        "value": [
                            0.61568629741669,
                            0.61568629741669,
                            0.61568629741669,
                            1
                        ]
                    }
                ],
                "check": {
                    "trigger": -1,
                    "value": 0,
                    "variable": "incombat"
                }
            },
            {
                "changes": [
                    {
                        "property": "color",
                        "value": [
                            1,
                            0,
                            0,
                            1
                        ]
                    }
                ],
                "check": {
                    "trigger": 2,
                    "value": 1,
                    "variable": "same"
                }
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 22
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "10",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 25
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "20",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 27
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "30",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 30
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "40",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 32
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "50",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 35
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "60",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 37
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "70",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 40
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "80",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 42
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "90",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 45
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "100",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 47
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "110",
                    "variable": "ccCount"
                },
                "linked": false
            },
            {
                "changes": [
                    {
                        "property": "sub.2.text_fontSize",
                        "value": 50
                    }
                ],
                "check": {
                    "op": ">=",
                    "trigger": 2,
                    "value": "120",
                    "variable": "ccCount"
                },
                "linked": false
            }
        ],
        "config": {
            "option": 1
        },
        "cooldown": true,
        "cooldownEdge": false,
        "cooldownSwipe": true,
        "cooldownTextDisabled": true,
        "customTextUpdate": "event",
        "desaturate": false,
        "desc": "Combos are fun. Keep them going, number goes up, dopamine goes brrrrr.\n\nNow you can track your Windwalker Combo Strikes mastery in true fighting game style with this Weakaura. ",
        "displayIcon": 572033,
        "displayText": "%%2.ccCount",
        "displayText_format_p_format": "timed",
        "displayText_format_p_time_dynamic_threshold": 60,
        "displayText_format_p_time_format": 0,
        "displayText_format_p_time_legacy_floor": false,
        "displayText_format_p_time_mod_rate": true,
        "displayText_format_p_time_precision": 1,
        "fixedWidth": 200,
        "font": "Friz Quadrata TT",
        "fontSize": 40,
        "frameStrata": 1,
        "height": 60,
        "icon": true,
        "iconSource": 2,
        "id": "Windwalker Combo Counter",
        "information": {
            "forceEvents": true,
            "ignoreOptionsEventErrors": true
        },
        "internalVersion": 64,
        "inverse": false,
        "justify": "LEFT",
        "keepAspectRatio": true,
        "load": {
            "class": {
                "multi": [],
                "single": "MONK"
            },
            "class_and_spec": {
                "multi": [
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null,
                    true
                ],
                "single": 269
            },
            "difficulty": {
                "multi": []
            },
            "faction": {
                "multi": []
            },
            "ingroup": {
                "multi": []
            },
            "pvptalent": {
                "multi": []
            },
            "race": {
                "multi": []
            },
            "role": {
                "multi": []
            },
            "size": {
                "multi": []
            },
            "spec": {
                "multi": [],
                "single": 3
            },
            "talent": {
                "multi": []
            },
            "talent2": {
                "multi": []
            },
            "use_class": true,
            "use_class_and_spec": true,
            "use_never": false,
            "use_petbattle": false,
            "use_spec": true,
            "use_vehicle": false,
            "use_vehicleUi": false,
            "zoneIds": ""
        },
        "outline": "OUTLINE",
        "regionType": "icon",
        "selfPoint": "CENTER",
        "semver": "1.0.5",
        "shadowColor": [
            0,
            0,
            0,
            1
        ],
        "shadowXOffset": 1,
        "shadowYOffset": -1,
        "source": "import",
        "stickyDuration": false,
        "subRegions": [
            {
                "type": "subbackground"
            },
            {
                "anchorXOffset": 0,
                "anchorYOffset": 0,
                "rotateText": "NONE",
                "text_anchorPoint": "OUTER_RIGHT",
                "text_automaticWidth": "Auto",
                "text_color": [
                    1,
                    1,
                    1,
                    1
                ],
                "text_fixedWidth": 64,
                "text_font": "Friz Quadrata TT",
                "text_fontSize": 20,
                "text_fontType": "OUTLINE",
                "text_justify": "RIGHT",
                "text_selfPoint": "AUTO",
                "text_shadowColor": [
                    0,
                    0,
                    0,
                    1
                ],
                "text_shadowXOffset": 0,
                "text_shadowYOffset": 0,
                "text_text": "%2.ccCount HITS!",
                "text_text_format_2.ccCount_decimal_precision": 0,
                "text_text_format_2.ccCount_format": "Number",
                "text_text_format_2.ccCount_round_type": "floor",
                "text_text_format_p_format": "timed",
                "text_text_format_p_time_dynamic_threshold": 60,
                "text_text_format_p_time_format": 0,
                "text_text_format_p_time_legacy_floor": false,
                "text_text_format_p_time_mod_rate": true,
                "text_text_format_p_time_precision": 1,
                "text_visible": true,
                "text_wordWrap": "WordWrap",
                "type": "subtext"
            },
            {
                "anchorXOffset": 0,
                "anchorYOffset": 0,
                "rotateText": "NONE",
                "text_anchorPoint": "OUTER_BOTTOMRIGHT",
                "text_anchorXOffset": 0,
                "text_anchorYOffset": 0,
                "text_automaticWidth": "Auto",
                "text_color": [
                    1,
                    1,
                    1,
                    1
                ],
                "text_fixedWidth": 64,
                "text_font": "Friz Quadrata TT",
                "text_fontSize": 20,
                "text_fontType": "OUTLINE",
                "text_justify": "CENTER",
                "text_selfPoint": "AUTO",
                "text_shadowColor": [
                    0,
                    0,
                    0,
                    1
                ],
                "text_shadowXOffset": 0,
                "text_shadowYOffset": 0,
                "text_text": "%2.exclamation",
                "text_text_format_2.exclamation_format": "none",
                "text_text_format_p_format": "timed",
                "text_text_format_p_time_dynamic_threshold": 60,
                "text_text_format_p_time_format": 0,
                "text_text_format_p_time_legacy_floor": false,
                "text_text_format_p_time_mod_rate": true,
                "text_text_format_p_time_precision": 1,
                "text_visible": true,
                "text_wordWrap": "WordWrap",
                "type": "subtext"
            }
        ],
        "tocversion": 100005,
        "triggers": {
            "1": {
                "trigger": {
                    "auraspellids": [
                        "196741"
                    ],
                    "debuffType": "HELPFUL",
                    "event": "Health",
                    "names": [],
                    "spellIds": [],
                    "subeventPrefix": "SPELL",
                    "subeventSuffix": "_CAST_START",
                    "type": "aura2",
                    "unit": "player",
                    "useExactSpellId": true
                },
                "untrigger": []
            },
            "2": {
                "trigger": {
                    "check": "event",
                    "custom": "function(allstates, _, _, _, spellID)\n    if spellID and aura_env.spellList[spellID] then\n        local sameAbility = allstates[\"\"] and allstates[\"\"].spellID == spellID\n        \n        if sameAbility then\n            --PlaySoundFile(\"Interface\\\\AddOns\\\\WeakAuras\\\\Media\\\\Sounds\\\\BananaPeelSlip.ogg\",\"SFX\")\n            aura_env.ccCounter = 0\n            aura_env.exclamation = \"Combo Broken!\"\n            \n        else \n            aura_env.ccCounter = aura_env.ccCounter + 1\n            for i, v in pairs(aura_env.exclamations) do\n                if aura_env.ccCounter == i then\n                    aura_env.exclamation = v\n                    break\n                end\n            end\n        end\n        \n        \n        allstates[\"\"] = {\n            show = true,\n            changed = true,\n            spellID = spellID,\n            ccCount = aura_env.ccCounter,\n            exclamation = aura_env.exclamation,\n            icon = select(3, GetSpellInfo(spellID)),\n            same = sameAbility,\n            autoHide = false\n        }\n        \n        \n        return true\n    end\nend",
                    "customDuration": "\n\n",
                    "customIcon": "\n\n\n",
                    "customName": "",
                    "customStacks": "\n\n",
                    "customVariables": "{\n    same = {\n        type = \"bool\",\n        display = \"Used same ability twice\"\n    },\n    \n    exclamation = {\n        type = \"string\",\n        display = \"cc exclamation\"\n    },\n    \n    ccCount = {\n        type = \"number\",\n        display = \"Combo Count\"\n    }\n}\n\n\n",
                    "custom_hide": "custom",
                    "custom_type": "stateupdate",
                    "debuffType": "HELPFUL",
                    "duration": "0",
                    "event": "Combat Log",
                    "events": "UNIT_SPELLCAST_SUCCEEDED:player",
                    "genericShowOn": "showOnActive",
                    "names": [],
                    "spellIds": [],
                    "subeventPrefix": "SPELL",
                    "subeventSuffix": "_CAST_START",
                    "type": "custom",
                    "unevent": "timed",
                    "unit": "player",
                    "use_messageType": false
                },
                "untrigger": {
                    "custom": "\n\n\n\n\n\n\n"
                }
            },
            "activeTriggerMode": 1,
            "customTriggerLogic": "",
            "disjunctive": "any"
        },
        "uid": "xlO49ksC)2D",
        "url": "https://wago.io/JGF9A3KdN/6",
        "useCooldownModRate": true,
        "useTooltip": false,
        "version": 6,
        "wagoID": "JGF9A3KdN",
        "width": 60,
        "wordWrap": "WordWrap",
        "xOffset": -367.99987792969,
        "yOffset": -62.299530029297,
        "zoom": 0.08
    },
    "m": "d",
    "s": "5.3.7",
    "v": 1421,
    "wagoID": "JGF9A3KdN"
}
