    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Cost: TMTNumericDataFieldEh
          FieldName = 'Cost'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Cost'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Description: TMTStringDataFieldEh
          FieldName = 'Description'
          StringDataType = fdtStringEh
          DisplayLabel = 'Description'
          DisplayWidth = 30
          Size = 30
          Transliterate = True
        end
        object ListPrice: TMTNumericDataFieldEh
          FieldName = 'ListPrice'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'ListPrice'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object OnHand: TMTNumericDataFieldEh
          FieldName = 'OnHand'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'OnHand'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object OnOrder: TMTNumericDataFieldEh
          FieldName = 'OnOrder'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'OnOrder'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object PartNo: TMTNumericDataFieldEh
          FieldName = 'PartNo'
          NumericDataType = fdtAutoIncEh
          AutoIncrement = False
          DisplayLabel = 'PartNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object VendorNo: TMTNumericDataFieldEh
          FieldName = 'VendorNo'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayLabel = 'VendorNo'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object VendorName: TMTStringDataFieldEh
          FieldName = 'VendorName'
          StringDataType = fdtStringEh
          DisplayLabel = 'VendorName'
          DisplayWidth = 200
          Size = 200
          Transliterate = True
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1356.750000000000000000
            'Dive kayak'
            3999.950000000000000000
            24.000000000000000000
            16.000000000000000000
            1
            6
            nil)
          (
            504.000000000000000000
            'Underwater Diver Vehicle'
            1680.000000000000000000
            5.000000000000000000
            3.000000000000000000
            2
            6
            nil)
          (
            117.500000000000000000
            'Regulator System'
            250.000000000000000000
            165.000000000000000000
            216.000000000000000000
            3
            4
            nil)
          (
            124.100000000000000000
            'Second Stage Regulator'
            365.000000000000000000
            98.000000000000000000
            88.000000000000000000
            4
            15
            nil)
          (
            119.350000000000000000
            'Regulator System'
            341.000000000000000000
            75.000000000000000000
            70.000000000000000000
            5
            4
            nil)
          (
            73.530000000000000000
            'Second Stage Regulator'
            171.000000000000000000
            37.000000000000000000
            35.000000000000000000
            6
            4
            nil)
          (
            154.800000000000000000
            'Regulator System'
            430.000000000000000000
            166.000000000000000000
            100.000000000000000000
            7
            4
            nil)
          (
            85.800000000000000000
            'Alternate Inflation Regulator'
            260.000000000000000000
            47.000000000000000000
            43.000000000000000000
            8
            4
            nil)
          (
            99.900000000000000000
            'Second Stage Regulator'
            270.000000000000000000
            128.000000000000000000
            135.000000000000000000
            9
            4
            nil)
          (
            64.600000000000000000
            'First Stage Regulator'
            170.000000000000000000
            146.000000000000000000
            140.000000000000000000
            10
            4
            nil)
          (
            95.790000000000000000
            'Second Stage Regulator'
            309.000000000000000000
            13.000000000000000000
            10.000000000000000000
            11
            21
            nil)
          (
            73.319999999999990000
            'Depth/Pressure Gauge Console'
            188.000000000000000000
            25.000000000000000000
            24.000000000000000000
            12
            21
            nil)
          (
            120.900000000000000000
            'Electronic Console'
            390.000000000000000000
            13.000000000000000000
            12.000000000000000000
            13
            4
            nil)
          (
            48.300000000000000000
            'Depth/Pressure Gauge'
            105.000000000000000000
            226.000000000000000000
            225.000000000000000000
            14
            4
            nil)
          (
            72.850000000000000000
            'Personal Dive Sonar'
            235.000000000000000000
            46.000000000000000000
            45.000000000000000000
            15
            4
            nil)
          (
            10.150000000000000000
            'Compass Console Mount'
            29.000000000000000000
            211.000000000000000000
            300.000000000000000000
            16
            4
            nil)
          (
            24.960000000000000000
            'Compass (meter only)'
            52.000000000000000000
            168.000000000000000000
            183.000000000000000000
            17
            4
            nil)
          (
            76.220000000000000000
            'Depth/Pressure Gauge'
            206.000000000000000000
            128.000000000000000000
            120.000000000000000000
            18
            4
            nil)
          (
            189.000000000000000000
            'Electronic Console w/ options'
            420.000000000000000000
            24.000000000000000000
            23.000000000000000000
            19
            4
            nil)
          (
            12.582000000000000000
            'Direct Sighting Compass'
            34.950000000000000000
            15.000000000000000000
            12.000000000000000000
            20
            1
            nil)
          (
            76.970000000000000000
            'Dive Computer'
            179.000000000000000000
            5.000000000000000000
            2.000000000000000000
            21
            1
            nil)
          (
            9.177000000000000000
            'Navigation Compass'
            19.950000000000000000
            8.000000000000000000
            20.000000000000000000
            22
            1
            nil)
          (
            7.920000000000000000
            'Wrist Band Thermometer (F)'
            18.000000000000000000
            6.000000000000000000
            3.000000000000000000
            23
            1
            nil)
          (
            53.640000000000000000
            'Depth/Pressure Gauge (Digital)'
            149.000000000000000000
            12.000000000000000000
            10.000000000000000000
            24
            1
            nil)
          (
            39.270000000000000000
            'Depth/Pressure Gauge (Analog)'
            119.000000000000000000
            16.000000000000000000
            15.000000000000000000
            25
            1
            nil)
          (
            6.480000000000000000
            'Wrist Band Thermometer (C)'
            18.000000000000000000
            12.000000000000000000
            10.000000000000000000
            26
            1
            nil)
          (
            253.500000000000000000
            'Dive Computer'
            650.000000000000000000
            45.000000000000000000
            43.000000000000000000
            27
            21
            nil)
          (
            146.200000000000000000
            'Stabilizing Vest'
            430.000000000000000000
            56.000000000000000000
            67.000000000000000000
            28
            4
            nil)
          (
            128.800000000000000000
            'Front Clip Stabilizing Vest'
            280.000000000000000000
            45.000000000000000000
            56.000000000000000000
            29
            4
            nil)
          (
            138.250000000000000000
            'Trim Fit Stabilizing Vest'
            395.000000000000000000
            63.000000000000000000
            61.000000000000000000
            30
            4
            nil)
          (
            109.200000000000000000
            'Welded Seam Stabilizing Vest'
            280.000000000000000000
            62.000000000000000000
            60.000000000000000000
            31
            4
            nil)
          (
            13.120000000000000000
            'Safety Knife'
            41.000000000000000000
            16.000000000000000000
            30.000000000000000000
            32
            4
            nil)
          (
            26.766500000000000000
            'Medium Titanium Knife'
            56.950000000000000000
            4.000000000000000000
            3.000000000000000000
            33
            15
            nil)
          (
            14.350000000000000000
            'Chisel Point Knife'
            41.000000000000000000
            14.000000000000000000
            35.000000000000000000
            34
            4
            nil)
          (
            29.250000000000000000
            'Flashlight'
            65.000000000000000000
            28.000000000000000000
            27.000000000000000000
            35
            4
            nil)
          (
            34.300000000000000000
            'Medium Stainless Steel Knife'
            70.000000000000000000
            30.000000000000000000
            23.000000000000000000
            36
            4
            nil)
          (
            27.300000000000000000
            'Divers Knife and Sheath'
            70.000000000000000000
            24.000000000000000000
            23.000000000000000000
            37
            4
            nil)
          (
            37.600000000000000000
            'Large Stainless Steel Knife'
            80.000000000000000000
            16.000000000000000000
            15.000000000000000000
            38
            4
            nil)
          (
            20.677000000000000000
            'Krypton Flashlight'
            44.950000000000000000
            46.000000000000000000
            76.000000000000000000
            39
            22
            nil)
          (
            50.985000000000000000
            'Flashlight (Rechargeable)'
            169.950000000000000000
            16.000000000000000000
            36.000000000000000000
            40
            22
            nil)
          (
            19.184000000000000000
            'Halogen Flashlight'
            59.950000000000000000
            19.000000000000000000
            18.000000000000000000
            41
            22
            nil)
          (
            57.280000000000000000
            '60.6 cu ft Tank'
            179.000000000000000000
            8.000000000000000000
            4.000000000000000000
            42
            4
            nil)
          (
            130.000000000000000000
            '95.1 cu ft Tank'
            325.000000000000000000
            16.000000000000000000
            14.000000000000000000
            43
            4
            nil)
          (
            58.500000000000000000
            '71.4 cu ft Tank'
            195.000000000000000000
            102.000000000000000000
            100.000000000000000000
            44
            4
            nil)
          (
            96.350000000000000000
            '75.8 cu ft Tank'
            235.000000000000000000
            38.000000000000000000
            31.000000000000000000
            45
            4
            nil)
          (
            710.700000000000000000
            'Remotely Operated Video System'
            2369.000000000000000000
            13.000000000000000000
            12.000000000000000000
            46
            3
            nil)
          (
            1124.100000000000000000
            'Marine Super VHS Video Package'
            2498.000000000000000000
            3.000000000000000000
            1.000000000000000000
            47
            22
            nil)
          (
            859.570000000000000000
            'Towable Video Camera (B&W)'
            1999.000000000000000000
            12.000000000000000000
            21.000000000000000000
            48
            10
            nil)
          (
            1484.550000000000000000
            'Towable Video Camera (Color)'
            3299.000000000000000000
            16.000000000000000000
            39.000000000000000000
            49
            10
            nil)
          (
            52.778000000000000000
            'Camera and Case'
            119.950000000000000000
            14.000000000000000000
            12.000000000000000000
            50
            22
            nil)
          (
            147.579500000000000000
            'Video Light'
            359.950000000000000000
            5.000000000000000000
            1.000000000000000000
            51
            22
            nil)
          (
            203.660000000000000000
            'Boat Towable Metal Detector'
            599.000000000000000000
            13.000000000000000000
            12.000000000000000000
            52
            3
            nil)
          (
            316.050000000000000000
            'Boat Towable Metal Detector'
            735.000000000000000000
            14.000000000000000000
            11.000000000000000000
            53
            3
            nil)
          (
            143.500000000000000000
            'Underwater Altimeter'
            350.000000000000000000
            38.000000000000000000
            34.000000000000000000
            54
            3
            nil)
          (
            215.110000000000000000
            'Sonar System'
            439.000000000000000000
            3.000000000000000000
            120.000000000000000000
            55
            3
            nil)
          (
            545.580000000000100000
            'Marine Magnetometer'
            1299.000000000000000000
            56.000000000000000000
            55.000000000000000000
            56
            3
            nil)
          (
            440.510000000000000000
            'Underwater Metal Detector'
            899.000000000000000000
            29.000000000000000000
            24.000000000000000000
            57
            3
            nil)
          (
            338.300000000000000000
            'Underwater Metal Detector'
            995.000000000000000000
            45.000000000000000000
            41.000000000000000000
            58
            3
            nil)
          (
            986.850000000000000000
            'Air Compressor'
            2295.000000000000000000
            5.000000000000000000
            2.000000000000000000
            59
            13
            nil)
          (
            nil
            'w'
            nil
            nil
            nil
            61
            nil
            nil)
          (
            nil
            'new'
            nil
            nil
            nil
            62
            1
            nil))
      end
    end
