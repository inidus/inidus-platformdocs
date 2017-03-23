---
title:  "Lab test implementation guidance"
sidebar: operon_sidebar
permalink: IMP1-lab-test-imp-guide.html
summary: This section contains clinical data repository implementation guidance for laboratory tests.
---

## A. Laboratory 'Panels'

Most laboratory results in haematology, biochemistry, immunology and virology are expressed as single analytes or as panels. Microbiology and histopathology (anatomic pathology) reports have a different structure and are modelled differently, and are described elsewhere.

### Overview

With the release of the laboratory Test series of archetype to Team Review, it was felt useful to provide guidance on the use of these archetypes, as, based on implementation experience, a very different approach is now suggested for handling laboratory tests.

### Glossary

**Laboratory Report** : The overall report as received from the laboratory, generally a COMPOSITION, which will contain one or more 'Laboratory Tests’.

**Laboratory Test**: The container OBSERVATION which contains details of the ordered laboratory investigation and overall conclusions. Examples: "Urea and Electrolytes", "Full blood count", "Glucose", "Prostate Cancer Histopathology"

**Laboratory Result** (Analyte): An individual result with a value. e.g. Hb, White cell count, Urea, Sodium, Glucose. A Lab Test may include only a single analyte or multiple analytes, often as part of a formal 'Laboratory panel'.

Each Laboratory Result will have a name e.g. "Hb" and a Value e.g. "12.2g/dl". The Name is generally coded, preferably with an external reference terminology like SNOMED CT, NPU or LOINC but local laboratory codes or controlled vocabularies are commonly used.

**Laboratory Panel**: A grouping of laboratory analytes, that generally reflect a grouped Test request, often aligned to the output of an automatic group analysis device. The exact make-up of a 'laboratory panel' varies between labs and lab analysers. i.e. The analytes included in a "Full blood Count", whilst broadly similar,  are not consistent across analysers.

***Notes:***

Where an individual analyte is requested the Test Name and the Result Name may be identical.

## Contexts of modelling use

Laboratory tests need to modelled in two quite different ways...

**1. Message-driven contexts**

Laboratory results are most commonly imported automatically via a structured message such as HL7v2, though other national messaging standards exist. The message structures can be quite variable and identification of the lab test and lab analytes make use of terminology. The exact structure of the incoming data is highly variable, and will depend on laboratory policy, variability of adherence to national standards, the exact lab analyser device used.

In essence the modeller is at the mercy of the laboratory message, and the target models have to be able to cope with inconsistent structures and coding.

**2. UI-driven contexts**

In some circumstances, the modeller is asked to construct a dataset which replicates one or more laboratory tests to underpin data-entry screens, or perhaps to pull data from a specific device. In these cases the optimal structure and optimal coding of test and analyte names will be known, and can be specified in the models.

In some systems, both contexts will be required and he challenge is to find an approach that allows consistent querying and retrieval.

## Previous modelling approaches

In previous modelling efforts, a generic OBSERVATION lab_test archetype was often specialised to represent common individual 'lab analytes' or 'lab panels' such as 'Lipid Profiles', 'Full Blood count'. Whilst this can work well for specific UI-driven contexts, it is much less helpful in messaging-driven contexts.

The variable nature of laboratory messaging and, in particular, the variable content of lab panels, makes it difficult for technical teams to map such messages to archetypes where the analyte pattern is strongly modelled.

## Proposed new modelling approach

1. Use a Generic OBSERVATION 'laboratory test' archetype as the basis for most, if not all laboratory tests, including microbiology and histopathology tests. This handles the ordered test name and other overall test-related data and is heavily aligned with the HL7v2 OBR segment and FHIR Diagnostic report resource.

2. Analyte (individual results) are handled by slotting in a variety of CLUSTER archetypes, the most common pattern being the simple tabular panel represented by CLUSTER.laboratory_test_panel. This pattern will handle the majority of tabular lab tests e.g. haematology and biochemistry. Other tests such as immunology may require different patterns and some specialities such as microbiology and histopathology will require more specific patterns. even where only a single analyte is reported, we recommend that it be carried within a laboratory panel structure to allow for consistent querying.

3. For tabular results in CLUSTER Laboratory Test Panel the result is carried as 'Result Value' with the name of the analyte as the Result Value /name attribute. This will normally be coded with a reference terminology.

4. It is not planned to try to create specific panel archetype specialisations or templates at international level, as, in practice the exact content of each panel varies enormously depending on the analyser and local lab terminology use. We make create a couple of exemplars for demo purposes, or where very specific additional metadata is required e.g. Glucose tolerance testing.

5. If, at a national or local level, it appears possible to construct more definitive 'hard-wired' representations of lab panels, this should be done by analytes and possible units via templating. Some examples will be provided in the international CKM but this will largely have to be a local exercise since it is highly dependent on local terminology use and messaging.

5. Microbiology is particularly difficult as their is a lack of consistent reporting of micro results. Experience shows that it is generally better to work with a more generic archetype which can respond to incoming data at run-time but we will attempt to define aspects of micro reporting, such as antibiotic sensitivities, for which clear standard patterns are emerging.


## Template examples

### Template for use in **message-driven** contexts.

An example of a template left generic to receive a variety of individual analytes or laboratory panels via a laboratory message can be found at http://openehr.org/ckm/#showTemplate_1013.26.185

### Template for use in **UI-driven** contexts

An example of a template constructed to represent a lipid profile for use to underpin data-entry or where the exact incoming lipid profile panel is known and consistent, is at http://openehr.org/ckm/#showTemplate_1013.26.69


### Instance Example "Structured JSON":

This example of openEHR data in 'Structured json' format, shows how laboratory test names, laboratory result names and values appear in openEHR data. The data format and paths should be identical regardless of whether a UI-driven or message-driven template approach is used.

```json
{
"laboratory_test#1": [
  {
    "test_name": [
        {
          "|code": "51990-0",
          "|value": "Basic metabolic panel- Blood",
          "|terminology": "SNOMED-CT"
        }
    ],
    "test_status": [
      {
        "|code": "at0038",
        "|value": "Final",
        "|terminology": "local"
      }
    ],
    "test_status_timestamp": [
        "2015-04-22T00:11:02.518+02:00"
    ],
    "laboratory_test_panel": [
      {
      "laboratory_result#1": [
        {
          "result_value": [
            {
             "_name": [
                {
                 "|value": "Urea",
                 "|code": "14937-7",
                 "|terminology": "LOINC"
                }
            ],
            "|magnitude": 7.8,
            "|unit": "mmol/l",
            "_normal_range": [
              {
                "lower": [
                    {
                    "|unit": "mmol/l",
                    "|magnitude": 2.5
                    }
                ],
                "upper": [
                  {
                    "|unit": "mmol/l",
                    "|magnitude": 6.6
                  }
                ]
              }
            ]
            },
          ],
          "comment": [
            "may be technical artefact"
          ]
        },
      ],
      "laboratory_result#2": [
        {
        "result_value": [
          {
            "_name": [
            {
              "|value": "Creatinine",
              "|code": "14682-9",
              "|terminology": "LOINC"
            }
          ],
            "|magnitude": 123,
            "|unit": "mmol/l",
            "_normal_range": [
            {
              "lower": [
                {
                "|unit": "mmol/l",
                "|magnitude": 80
                }
              ],
              "upper": [
                {
                "|unit": "mmol/l",
                "|magnitude": 110
                }
              ]
            }
          ]
        }
      ]
    },
  ],
  "conclusion": [
  "Very rapidly deteriorating renal function"
  ],
}
],
"laboratory_test#2": [
  {
    "test_name": [
        {
          "|code": "15074-8",
          "|value": "Glucose",
          "|terminology": "LOINC"
        }
    ],
    "test_status": [
      {
        "|code": "at0038",
        "|value": "Final",
        "|terminology": "local"
      }
    ],
    "test_status_timestamp": [
        "2015-04-22T00:11:02.518+02:00"
    ],
    "laboratory_test_panel": [
      {
      "laboratory_result": [
        {
          "result_value": [
            {
             "_name": [
                {
                 "|value": "Glucose",
                 "|code": "15074-8",
                 "|terminology": "LOINC"
                }
            ],
            "|magnitude": 4.2,
            "|unit": "mmol/l",
            "_normal_range": [
              {
                "lower": [
                  {
                  "|unit": "mmol/l",
                  "|magnitude": 1.3
                  }
                ],
                "upper": [
                  {
                  "|unit": "mmol/l",
                  "|magnitude": 6.6
                  }
                ]
              }
            ]
            }
          ]
        }
      ],
      "comment": [
        "may be technical artefact"
      ]
      }
    ],
    "conclusion": [
        "Normal for age"
    ]
  }
]
```
