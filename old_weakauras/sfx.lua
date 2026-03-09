{
    "c": [
        {
            "actions": {
                "finish": [],
                "init": [],
                "start": {
                    "do_sound": true,
                    "sound": " custom",
                    "sound_channel": "SFX",
                    "sound_path": "Interface\\AddOns\\SharedMedia_Custom\\sf2_hadoken.ogg"
                }
            },
            "anchorFrameType": "SCREEN",
            "anchorPoint": "CENTER",
            "animation": {
                "finish": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "main": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "start": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                }
            },
            "authorOptions": [],
            "automaticWidth": "Auto",
            "color": [
                1,
                1,
                1,
                1
            ],
            "conditions": [],
            "config": [],
            "customTextUpdate": "event",
            "displayText": "",
            "displayText_format_p_format": "timed",
            "displayText_format_p_time_dynamic_threshold": 60,
            "displayText_format_p_time_format": 0,
            "displayText_format_p_time_precision": 1,
            "fixedWidth": 200,
            "font": "Friz Quadrata TT",
            "fontSize": 12,
            "frameStrata": 1,
            "id": "Hadoken!",
            "information": {
                "forceEvents": true
            },
            "internalVersion": 77,
            "justify": "LEFT",
            "load": {
                "class": {
                    "multi": []
                },
                "class_and_spec": {
                    "single": 269
                },
                "size": {
                    "multi": []
                },
                "spec": {
                    "multi": []
                },
                "spellknown": 123986,
                "talent": {
                    "multi": {
                        "3": true,
                        "123986": true,
                        "124952": true
                    }
                },
                "use_class_and_spec": true,
                "use_spellknown": false,
                "use_talent": false
            },
            "outline": "OUTLINE",
            "regionType": "text",
            "selfPoint": "BOTTOM",
            "semver": "1.0.6",
            "shadowColor": [
                0,
                0,
                0,
                1
            ],
            "shadowXOffset": 1,
            "shadowYOffset": -1,
            "source": "import",
            "subRegions": [
                {
                    "type": "subbackground"
                }
            ],
            "tocversion": 110002,
            "triggers": {
                "1": {
                    "trigger": {
                        "debuffType": "HELPFUL",
                        "event": "Combat Log",
                        "genericShowOn": "showOnCooldown",
                        "names": [],
                        "realSpellName": "Chi Burst",
                        "sourceUnit": "player",
                        "spellId": [
                            461404
                        ],
                        "spellIds": [],
                        "spellName": [
                            "Chi Burst"
                        ],
                        "subeventPrefix": "SPELL",
                        "subeventSuffix": "_CAST_START",
                        "type": "combatlog",
                        "unit": "player",
                        "use_cloneId": false,
                        "use_genericShowOn": true,
                        "use_sourceUnit": true,
                        "use_spellId": true,
                        "use_spellName": false,
                        "use_track": true
                    },
                    "untrigger": []
                },
                "activeTriggerMode": -10,
                "disjunctive": "any"
            },
            "uid": "IsbHBnBnqut",
            "url": "https://wago.io/q-nfpE_Y4/7",
            "version": 7,
            "wagoID": "q-nfpE_Y4",
            "wordWrap": "WordWrap",
            "xOffset": -0.5,
            "yOffset": 37.000183105469
        },
        {
            "actions": {
                "finish": [],
                "init": [],
                "start": {
                    "do_sound": true,
                    "sound": " custom",
                    "sound_channel": "SFX",
                    "sound_path": "Interface\\AddOns\\SharedMedia_Custom\\sf2_sbk.ogg"
                }
            },
            "anchorFrameType": "SCREEN",
            "anchorPoint": "CENTER",
            "animation": {
                "finish": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "main": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "start": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                }
            },
            "authorOptions": [],
            "automaticWidth": "Auto",
            "color": [
                1,
                1,
                1,
                1
            ],
            "conditions": [],
            "config": [],
            "customTextUpdate": "event",
            "displayText": "",
            "displayText_format_p_format": "timed",
            "displayText_format_p_time_dynamic_threshold": 60,
            "displayText_format_p_time_format": 0,
            "displayText_format_p_time_precision": 1,
            "fixedWidth": 200,
            "font": "Friz Quadrata TT",
            "fontSize": 12,
            "frameStrata": 1,
            "id": "Spinning Bird Kick!",
            "information": {
                "forceEvents": true
            },
            "internalVersion": 77,
            "justify": "LEFT",
            "load": {
                "class": {
                    "multi": []
                },
                "class_and_spec": {
                    "single": 269
                },
                "size": {
                    "multi": []
                },
                "spec": {
                    "multi": []
                },
                "talent": {
                    "multi": [
                        null,
                        null,
                        true
                    ]
                },
                "use_class_and_spec": true
            },
            "outline": "OUTLINE",
            "regionType": "text",
            "selfPoint": "BOTTOM",
            "semver": "1.0.6",
            "shadowColor": [
                0,
                0,
                0,
                1
            ],
            "shadowXOffset": 1,
            "shadowYOffset": -1,
            "source": "import",
            "subRegions": [
                {
                    "type": "subbackground"
                }
            ],
            "tocversion": 110002,
            "triggers": {
                "1": {
                    "trigger": {
                        "debuffType": "HELPFUL",
                        "event": "Combat Log",
                        "genericShowOn": "showOnCooldown",
                        "names": [],
                        "realSpellName": "Chi Burst",
                        "sourceUnit": "player",
                        "spellId": [
                            "119381"
                        ],
                        "spellIds": [],
                        "spellName": [
                            "Leg Sweep"
                        ],
                        "subeventPrefix": "SPELL",
                        "subeventSuffix": "_CAST_SUCCESS",
                        "type": "combatlog",
                        "unit": "player",
                        "use_cloneId": false,
                        "use_genericShowOn": true,
                        "use_sourceUnit": true,
                        "use_spellId": true,
                        "use_spellName": false,
                        "use_track": true
                    },
                    "untrigger": []
                },
                "activeTriggerMode": -10,
                "disjunctive": "any"
            },
            "uid": "r9SQd8b(KEZ",
            "url": "https://wago.io/q-nfpE_Y4/7",
            "version": 7,
            "wagoID": "q-nfpE_Y4",
            "wordWrap": "WordWrap",
            "xOffset": -0.5,
            "yOffset": 37.000183105469
        },
        {
            "actions": {
                "finish": [],
                "init": [],
                "start": {
                    "do_sound": true,
                    "sound": " custom",
                    "sound_channel": "SFX",
                    "sound_path": "Interface\\AddOns\\SharedMedia_Custom\\sf2_hhs.ogg"
                }
            },
            "anchorFrameType": "SCREEN",
            "anchorPoint": "CENTER",
            "animation": {
                "finish": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "main": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "start": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                }
            },
            "authorOptions": [],
            "automaticWidth": "Auto",
            "color": [
                1,
                1,
                1,
                1
            ],
            "conditions": [],
            "config": [],
            "customTextUpdate": "event",
            "displayText": "",
            "displayText_format_p_format": "timed",
            "displayText_format_p_time_dynamic_threshold": 60,
            "displayText_format_p_time_format": 0,
            "displayText_format_p_time_precision": 1,
            "fixedWidth": 200,
            "font": "Friz Quadrata TT",
            "fontSize": 12,
            "frameStrata": 1,
            "id": "Hundred Hand Slap!",
            "information": {
                "forceEvents": true
            },
            "internalVersion": 77,
            "justify": "LEFT",
            "load": {
                "class": {
                    "multi": []
                },
                "class_and_spec": {
                    "single": 269
                },
                "size": {
                    "multi": []
                },
                "spec": {
                    "multi": []
                },
                "talent": {
                    "multi": [
                        null,
                        null,
                        true
                    ]
                },
                "use_class_and_spec": true
            },
            "outline": "OUTLINE",
            "regionType": "text",
            "selfPoint": "BOTTOM",
            "semver": "1.0.6",
            "shadowColor": [
                0,
                0,
                0,
                1
            ],
            "shadowXOffset": 1,
            "shadowYOffset": -1,
            "source": "import",
            "subRegions": [
                {
                    "type": "subbackground"
                }
            ],
            "tocversion": 110002,
            "triggers": {
                "1": {
                    "trigger": {
                        "debuffType": "HELPFUL",
                        "event": "Combat Log",
                        "genericShowOn": "showOnCooldown",
                        "names": [],
                        "realSpellName": "Chi Burst",
                        "sourceUnit": "player",
                        "spellId": [
                            "113656"
                        ],
                        "spellIds": [],
                        "spellName": [
                            "Fists of Fury"
                        ],
                        "subeventPrefix": "SPELL",
                        "subeventSuffix": "_CAST_SUCCESS",
                        "type": "combatlog",
                        "unit": "player",
                        "use_cloneId": false,
                        "use_genericShowOn": true,
                        "use_sourceUnit": true,
                        "use_spellId": true,
                        "use_spellName": false,
                        "use_track": true
                    },
                    "untrigger": []
                },
                "activeTriggerMode": -10,
                "disjunctive": "any"
            },
            "uid": ")kwuOVVQFmD",
            "url": "https://wago.io/q-nfpE_Y4/7",
            "version": 7,
            "wagoID": "q-nfpE_Y4",
            "wordWrap": "WordWrap",
            "xOffset": -2.5,
            "yOffset": 37.000183105469
        },
        {
            "actions": {
                "finish": [],
                "init": [],
                "start": {
                    "do_sound": true,
                    "sound": " custom",
                    "sound_channel": "SFX",
                    "sound_path": "Interface\\AddOns\\SharedMedia_Custom\\sf2_shoryuken.ogg"
                }
            },
            "anchorFrameType": "SCREEN",
            "anchorPoint": "CENTER",
            "animation": {
                "finish": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "main": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "start": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                }
            },
            "authorOptions": [],
            "automaticWidth": "Auto",
            "color": [
                1,
                1,
                1,
                1
            ],
            "conditions": [],
            "config": [],
            "customTextUpdate": "event",
            "displayText": "",
            "displayText_format_p_format": "timed",
            "displayText_format_p_time_dynamic_threshold": 60,
            "displayText_format_p_time_format": 0,
            "displayText_format_p_time_precision": 1,
            "fixedWidth": 200,
            "font": "Friz Quadrata TT",
            "fontSize": 12,
            "frameStrata": 1,
            "id": "Shoryuken!",
            "information": {
                "forceEvents": true
            },
            "internalVersion": 77,
            "justify": "LEFT",
            "load": {
                "class": {
                    "multi": []
                },
                "class_and_spec": {
                    "single": 269
                },
                "size": {
                    "multi": []
                },
                "spec": {
                    "multi": []
                },
                "talent": {
                    "multi": {
                        "125011": true
                    }
                },
                "use_class_and_spec": true,
                "use_talent": false
            },
            "outline": "OUTLINE",
            "regionType": "text",
            "selfPoint": "BOTTOM",
            "semver": "1.0.6",
            "shadowColor": [
                0,
                0,
                0,
                1
            ],
            "shadowXOffset": 1,
            "shadowYOffset": -1,
            "source": "import",
            "subRegions": [
                {
                    "type": "subbackground"
                }
            ],
            "tocversion": 110002,
            "triggers": {
                "1": {
                    "trigger": {
                        "debuffType": "HELPFUL",
                        "event": "Combat Log",
                        "genericShowOn": "showOnCooldown",
                        "names": [],
                        "realSpellName": 0,
                        "sourceUnit": "player",
                        "spellId": [
                            "152175"
                        ],
                        "spellIds": [],
                        "spellName": [
                            "Whirling Dragon Punch"
                        ],
                        "subeventPrefix": "SPELL",
                        "subeventSuffix": "_CAST_SUCCESS",
                        "type": "combatlog",
                        "unit": "player",
                        "use_genericShowOn": true,
                        "use_sourceName": false,
                        "use_sourceUnit": true,
                        "use_spellId": true,
                        "use_spellName": false,
                        "use_track": true
                    },
                    "untrigger": []
                },
                "activeTriggerMode": -10,
                "disjunctive": "all"
            },
            "uid": "qD8PUW8tI8i",
            "url": "https://wago.io/q-nfpE_Y4/7",
            "version": 7,
            "wagoID": "q-nfpE_Y4",
            "wordWrap": "WordWrap",
            "xOffset": -4.5,
            "yOffset": 37.000183105469
        },
        {
            "actions": {
                "finish": [],
                "init": [],
                "start": {
                    "do_sound": true,
                    "sound": " custom",
                    "sound_channel": "SFX",
                    "sound_path": "Interface\\AddOns\\SharedMedia_Custom\\sf2_tatsu.ogg"
                }
            },
            "anchorFrameType": "SCREEN",
            "anchorPoint": "CENTER",
            "animation": {
                "finish": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "main": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "start": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                }
            },
            "authorOptions": [],
            "automaticWidth": "Auto",
            "color": [
                1,
                1,
                1,
                1
            ],
            "conditions": [],
            "config": [],
            "customTextUpdate": "event",
            "displayText": "",
            "displayText_format_p_format": "timed",
            "displayText_format_p_time_dynamic_threshold": 60,
            "displayText_format_p_time_format": 0,
            "displayText_format_p_time_precision": 1,
            "fixedWidth": 200,
            "font": "Friz Quadrata TT",
            "fontSize": 12,
            "frameStrata": 1,
            "id": "Tatsumaki Senpukyaku!",
            "information": {
                "forceEvents": true
            },
            "internalVersion": 77,
            "justify": "LEFT",
            "load": {
                "class": {
                    "multi": []
                },
                "class_and_spec": {
                    "single": 269
                },
                "size": {
                    "multi": []
                },
                "spec": {
                    "multi": []
                },
                "talent": {
                    "multi": {
                        "391370": true
                    },
                    "single": 18
                },
                "use_class_and_spec": true
            },
            "outline": "OUTLINE",
            "regionType": "text",
            "selfPoint": "BOTTOM",
            "semver": "1.0.6",
            "shadowColor": [
                0,
                0,
                0,
                1
            ],
            "shadowXOffset": 1,
            "shadowYOffset": -1,
            "source": "import",
            "subRegions": [
                {
                    "type": "subbackground"
                }
            ],
            "tocversion": 110002,
            "triggers": {
                "1": {
                    "trigger": {
                        "debuffType": "HELPFUL",
                        "event": "Combat Log",
                        "genericShowOn": "showOnCooldown",
                        "names": [],
                        "realSpellName": 0,
                        "sourceUnit": "player",
                        "spellId": [
                            "101546"
                        ],
                        "spellIds": [],
                        "spellName": [
                            "Spinning Crane Kick"
                        ],
                        "subeventPrefix": "SPELL",
                        "subeventSuffix": "_CAST_SUCCESS",
                        "type": "combatlog",
                        "unit": "player",
                        "use_genericShowOn": true,
                        "use_sourceName": false,
                        "use_sourceUnit": true,
                        "use_spellId": true,
                        "use_spellName": false,
                        "use_track": true
                    },
                    "untrigger": []
                },
                "activeTriggerMode": -10,
                "disjunctive": "all"
            },
            "uid": "dM1yo0iE(Zx",
            "url": "https://wago.io/q-nfpE_Y4/7",
            "version": 7,
            "wagoID": "q-nfpE_Y4",
            "wordWrap": "WordWrap",
            "xOffset": -6.5,
            "yOffset": 38.000183105469
        },
        {
            "actions": {
                "finish": [],
                "init": [],
                "start": {
                    "do_sound": true,
                    "sound": " custom",
                    "sound_channel": "SFX",
                    "sound_path": "Interface\\AddOns\\SharedMedia_Custom\\sf2_tiger.ogg"
                }
            },
            "anchorFrameType": "SCREEN",
            "anchorPoint": "CENTER",
            "animation": {
                "finish": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "main": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "start": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                }
            },
            "authorOptions": [],
            "automaticWidth": "Auto",
            "color": [
                1,
                1,
                1,
                1
            ],
            "conditions": [],
            "config": [],
            "customTextUpdate": "event",
            "displayText": "",
            "displayText_format_p_format": "timed",
            "displayText_format_p_time_dynamic_threshold": 60,
            "displayText_format_p_time_format": 0,
            "displayText_format_p_time_precision": 1,
            "fixedWidth": 200,
            "font": "Friz Quadrata TT",
            "fontSize": 12,
            "frameStrata": 1,
            "id": "Tiger!",
            "information": {
                "forceEvents": true
            },
            "internalVersion": 77,
            "justify": "LEFT",
            "load": {
                "class": {
                    "multi": []
                },
                "class_and_spec": {
                    "single": 269
                },
                "size": {
                    "multi": []
                },
                "spec": {
                    "multi": []
                },
                "talent": {
                    "multi": []
                },
                "use_class_and_spec": true
            },
            "outline": "OUTLINE",
            "regionType": "text",
            "selfPoint": "BOTTOM",
            "semver": "1.0.6",
            "shadowColor": [
                0,
                0,
                0,
                1
            ],
            "shadowXOffset": 1,
            "shadowYOffset": -1,
            "source": "import",
            "subRegions": [
                {
                    "type": "subbackground"
                }
            ],
            "tocversion": 110002,
            "triggers": {
                "1": {
                    "trigger": {
                        "debuffType": "HELPFUL",
                        "event": "Combat Log",
                        "genericShowOn": "showOnCooldown",
                        "names": [],
                        "realSpellName": 0,
                        "sourceUnit": "player",
                        "spellId": [
                            "100780"
                        ],
                        "spellIds": [],
                        "spellName": [
                            "Tiger Palm"
                        ],
                        "subeventPrefix": "SPELL",
                        "subeventSuffix": "_CAST_SUCCESS",
                        "type": "combatlog",
                        "unit": "player",
                        "use_genericShowOn": true,
                        "use_sourceUnit": true,
                        "use_spellId": true,
                        "use_spellName": false,
                        "use_track": true
                    },
                    "untrigger": []
                },
                "activeTriggerMode": -10,
                "disjunctive": "any"
            },
            "uid": "TB7qvbhGrfl",
            "url": "https://wago.io/q-nfpE_Y4/7",
            "version": 7,
            "wagoID": "q-nfpE_Y4",
            "wordWrap": "WordWrap",
            "xOffset": -8.5,
            "yOffset": 38.000183105469
        },
        {
            "actions": {
                "finish": [],
                "init": [],
                "start": {
                    "do_sound": true,
                    "sound": " custom",
                    "sound_channel": "SFX",
                    "sound_path": "Interface\\AddOns\\SharedMedia_Custom\\sf4_flash_kick.ogg"
                }
            },
            "anchorFrameType": "SCREEN",
            "anchorPoint": "CENTER",
            "animation": {
                "finish": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "main": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "start": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                }
            },
            "authorOptions": [],
            "automaticWidth": "Auto",
            "color": [
                1,
                1,
                1,
                1
            ],
            "conditions": [],
            "config": [],
            "customTextUpdate": "event",
            "displayText": "",
            "displayText_format_p_format": "timed",
            "displayText_format_p_time_dynamic_threshold": 60,
            "displayText_format_p_time_format": 0,
            "displayText_format_p_time_precision": 1,
            "fixedWidth": 200,
            "font": "Friz Quadrata TT",
            "fontSize": 12,
            "frameStrata": 1,
            "id": "Flash Kick!",
            "information": {
                "forceEvents": true
            },
            "internalVersion": 77,
            "justify": "LEFT",
            "load": {
                "class": {
                    "multi": []
                },
                "class_and_spec": {
                    "single": 269
                },
                "size": {
                    "multi": []
                },
                "spec": {
                    "multi": []
                },
                "talent": {
                    "multi": {
                        "124985": true
                    }
                },
                "use_class_and_spec": true,
                "use_talent": false
            },
            "outline": "OUTLINE",
            "regionType": "text",
            "selfPoint": "BOTTOM",
            "semver": "1.0.6",
            "shadowColor": [
                0,
                0,
                0,
                1
            ],
            "shadowXOffset": 1,
            "shadowYOffset": -1,
            "source": "import",
            "subRegions": [
                {
                    "type": "subbackground"
                }
            ],
            "tocversion": 110002,
            "triggers": {
                "1": {
                    "trigger": {
                        "debuffType": "HELPFUL",
                        "event": "Combat Log",
                        "genericShowOn": "showOnCooldown",
                        "names": [],
                        "realSpellName": 0,
                        "sourceUnit": "player",
                        "spellId": [
                            "107428"
                        ],
                        "spellIds": [],
                        "spellName": [
                            "Rising Sun Kick"
                        ],
                        "subeventPrefix": "SPELL",
                        "subeventSuffix": "_CAST_SUCCESS",
                        "type": "combatlog",
                        "unit": "player",
                        "use_genericShowOn": true,
                        "use_sourceUnit": true,
                        "use_spellId": true,
                        "use_spellName": false,
                        "use_track": true
                    },
                    "untrigger": []
                },
                "activeTriggerMode": -10,
                "disjunctive": "any"
            },
            "uid": "9uL647ErmOb",
            "url": "https://wago.io/q-nfpE_Y4/7",
            "version": 7,
            "wagoID": "q-nfpE_Y4",
            "wordWrap": "WordWrap",
            "xOffset": -8.5,
            "yOffset": 38.000183105469
        },
        {
            "actions": {
                "finish": [],
                "init": [],
                "start": {
                    "do_sound": true,
                    "sound": " custom",
                    "sound_channel": "SFX",
                    "sound_path": "Interface\\AddOns\\SharedMedia_Custom\\sf2_sonicboom.ogg"
                }
            },
            "anchorFrameType": "SCREEN",
            "anchorPoint": "CENTER",
            "animation": {
                "finish": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "main": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                },
                "start": {
                    "duration_type": "seconds",
                    "easeStrength": 3,
                    "easeType": "none",
                    "type": "none"
                }
            },
            "authorOptions": [],
            "automaticWidth": "Auto",
            "color": [
                1,
                1,
                1,
                1
            ],
            "conditions": [],
            "config": [],
            "customTextUpdate": "event",
            "displayText": "",
            "displayText_format_p_format": "timed",
            "displayText_format_p_time_dynamic_threshold": 60,
            "displayText_format_p_time_format": 0,
            "displayText_format_p_time_precision": 1,
            "fixedWidth": 200,
            "font": "Friz Quadrata TT",
            "fontSize": 12,
            "frameStrata": 1,
            "id": "Sonic Boom!",
            "information": {
                "forceEvents": true
            },
            "internalVersion": 77,
            "justify": "LEFT",
            "load": {
                "class": {
                    "multi": []
                },
                "class_and_spec": {
                    "single": 269
                },
                "size": {
                    "multi": []
                },
                "spec": {
                    "multi": []
                },
                "talent": {
                    "multi": {
                        "125022": true
                    }
                },
                "talent2": {
                    "multi": []
                },
                "use_class_and_spec": true,
                "use_talent": false
            },
            "outline": "OUTLINE",
            "regionType": "text",
            "selfPoint": "BOTTOM",
            "semver": "1.0.6",
            "shadowColor": [
                0,
                0,
                0,
                1
            ],
            "shadowXOffset": 1,
            "shadowYOffset": -1,
            "source": "import",
            "subRegions": [
                {
                    "type": "subbackground"
                }
            ],
            "tocversion": 110002,
            "triggers": {
                "1": {
                    "trigger": {
                        "debuffType": "HELPFUL",
                        "event": "Combat Log",
                        "genericShowOn": "showOnCooldown",
                        "names": [],
                        "realSpellName": 0,
                        "sourceUnit": "player",
                        "spellId": [
                            "392983"
                        ],
                        "spellIds": [],
                        "spellName": [
                            "Rising Sun Kick"
                        ],
                        "subeventPrefix": "SPELL",
                        "subeventSuffix": "_CAST_SUCCESS",
                        "type": "combatlog",
                        "unit": "player",
                        "use_genericShowOn": true,
                        "use_sourceUnit": true,
                        "use_spellId": true,
                        "use_spellName": false,
                        "use_track": true
                    },
                    "untrigger": []
                },
                "activeTriggerMode": -10,
                "disjunctive": "any"
            },
            "uid": "Zx13)NuQSNh",
            "url": "https://wago.io/q-nfpE_Y4/7",
            "version": 7,
            "wagoID": "q-nfpE_Y4",
            "wordWrap": "WordWrap",
            "xOffset": -8.5,
            "yOffset": 38.000183105469
        }
    ],
    "d": {
        "actions": {
            "finish": [],
            "init": [],
            "start": []
        },
        "alpha": 1,
        "anchorFrameType": "SCREEN",
        "anchorPoint": "TOPLEFT",
        "animation": {
            "finish": {
                "duration_type": "seconds",
                "easeStrength": 3,
                "easeType": "none",
                "type": "none"
            },
            "main": {
                "duration_type": "seconds",
                "easeStrength": 3,
                "easeType": "none",
                "type": "none"
            },
            "start": {
                "duration_type": "seconds",
                "easeStrength": 3,
                "easeType": "none",
                "type": "none"
            }
        },
        "authorOptions": [],
        "backdropColor": [
            1,
            1,
            1,
            0.5
        ],
        "border": false,
        "borderBackdrop": "Blizzard Tooltip",
        "borderColor": [
            0,
            0,
            0,
            1
        ],
        "borderEdge": "Square Full White",
        "borderInset": 1,
        "borderOffset": 4,
        "borderSize": 2,
        "conditions": [],
        "config": [],
        "desc": "Unleash your inner World Warrior! Requires sounds in Interface\\AddOns\\SharedMedia_Custom",
        "frameStrata": 1,
        "groupIcon": 132938,
        "id": "SF2 WW SFX",
        "information": {
            "debugLog": false,
            "forceEvents": true
        },
        "internalVersion": 77,
        "load": {
            "class": {
                "multi": []
            },
            "size": {
                "multi": []
            },
            "spec": {
                "multi": []
            },
            "talent": {
                "multi": []
            }
        },
        "regionType": "group",
        "scale": 0.05,
        "selfPoint": "CENTER",
        "semver": "1.0.6",
        "source": "import",
        "subRegions": [],
        "tocversion": 110002,
        "triggers": [
            {
                "trigger": {
                    "debuffType": "HELPFUL",
                    "event": "Health",
                    "names": [],
                    "spellIds": [],
                    "subeventPrefix": "SPELL",
                    "subeventSuffix": "_CAST_START",
                    "type": "aura2",
                    "unit": "player"
                },
                "untrigger": []
            }
        ],
        "uid": "6cJc7UPZl4J",
        "url": "https://wago.io/q-nfpE_Y4/7",
        "version": 7,
        "wagoID": "q-nfpE_Y4",
        "xOffset": -1920,
        "yOffset": 30
    },
    "m": "d",
    "s": "5.17.1",
    "v": 1421,
    "wagoID": "q-nfpE_Y4"
}
