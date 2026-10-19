| No | Original Column | Clean Column | Type | Category | Description | Formula/Function/Hardcode Value | Action | Validation Notes |
|---:|:---|:---|:---|:---|:---|:---|:---|:---|
| 1 | FRN's Date | FRN Date | Date | Receiving | Ngày nhận hàng/FRN | Hardcoded Value | Keep | |
| 2 | Location | Location | Text | Warehouse | Vị trí lưu kho | Hardcoded Value | Keep | |
| 3 | Age (days) | Age Days | Integer | Inventory | Số ngày hàng nằm kho | Function | Recalculate | |
| 4 | Stack | Stack | Text | Warehouse | Mã/vị trí stack | Hardcoded Value | Keep | |
| 5 | Name | Product Name | Text | Product | Tên hàng | Hardcoded Value | Keep | |
| 6 | Code | Product Code | Text | Product | Mã hàng nội bộ | Hardcoded Value | Keep | |
| 7 | SAP Code | SAP Code | Text | Product | Mã hàng SAP | Function | Keep | |
| 8 | Grade | Grade | Text | Product | Cấp/loại hàng | Hardcoded Value | Keep | |
| 9 | FRN No | FRN No | Text | Receiving | Số FRN | Hardcoded Value | Keep | Missing values detected |
| 10 | TALLY SHEET NO. | Tally Sheet No | Text | Receiving | Số phiếu tally | Hardcoded Value | Keep | |
| 11 | TALLY SHEET BAG | Tally Sheet Bags | Integer | Receiving | Số bao theo tally | Hardcoded Value | Keep | |
| 12 | TALLY SHEET' s QTY | Tally Sheet Qty | Decimal | Receiving | Khối lượng theo tally | Hardcoded Value | Keep | |
| 13 | FRN's Bag | FRN Bags | Integer | Receiving | Số bao theo FRN | Hardcoded Value | Keep | |
| 14 | Stock | Stock | Decimal | Inventory | Giá trị/lượng stock gốc | Hardcoded Value | Review | |
| 15 | FRN's Qty | FRN Qty | Decimal | Receiving | Khối lượng theo FRN | Hardcoded Value | Keep | |
| 16 | Mc in | MC In | Decimal | Quality | Moisture khi nhập | Hardcoded Value | Keep | |
| 17 | D in | D In | Decimal | Quality | Chỉ tiêu D khi nhập | Hardcoded Value | Keep | |
| 18 | FM in | FM In | Decimal | Quality | Foreign matter khi nhập | Hardcoded Value | Keep | |
| 19 | Mld | MLD | Decimal | Quality | Chỉ tiêu MLD | Hardcoded Value | Keep | |
| 20 | Lb % | LB Pct | Decimal | Quality | Tỷ lệ LB | Hardcoded Value | Keep | |
| 21 | VO | VO | Decimal | Quality | Chỉ tiêu VO | Hardcoded Value | Keep | |
| 22 | Rmin's Bags | Rmin Bags | Integer | Inventory | Số bao Rmin | Hardcoded Value | Keep | |
| 23 | Rmin's Qty | Rmin Qty | Decimal | Inventory | Khối lượng Rmin | Hardcoded Value | Keep | |
| 24 | Date | Issue Date | Date | Issue | Ngày xuất | Hardcoded Value | Keep | |
| 25 | Balance Bags | Balance Bags | Integer | Inventory | Số bao còn lại | Formula | Keep | |
| 26 | Balance Qty | Balance Qty | Decimal | Inventory | Khối lượng còn lại | Formula | Keep | |
| 27 | Sum of Difference FRN-Balance Qty | FRN Balance Difference | Decimal | Inventory | Chênh lệch FRN và tồn | Function | Recalculate | |
| 28 | Actual issue (Bags) | Actual Issue Bags | Integer | Issue | Số bao thực xuất | Formula | Keep | |
| 29 | Actual Issue Qty | Actual Issue Qty | Decimal | Issue | Khối lượng thực xuất | Hardcoded Value | Keep | |
| 30 | Issue MC | Issue MC | Decimal | Quality | Moisture khi xuất | Hardcoded Value | Keep | |
| 31 | Issue D | Issue D | Decimal | Quality | Chỉ tiêu D khi xuất | Hardcoded Value | Keep | |
| 32 | Wloss | Weight Loss | Decimal | Loss | Hao hụt trọng lượng | Formula | Keep | |
| 33 | MC's Loss | MC Loss | Decimal | Loss | Hao hụt do moisture | Formula | Keep | |
| 34 | Unexplain | Unexplained Loss | Decimal | Loss | Hao hụt chưa giải thích | Formula | Keep | |
| 35 | % Wloss | Weight Loss Pct | Decimal | Loss | Tỷ lệ weight loss | Formula | Recalculate | |
| 36 | % MC Loss | MC Loss Pct | Decimal | Loss | Tỷ lệ moisture loss | Formula | Recalculate | |
| 37 | % Unexplain Loss | Unexplained Loss Pct | Decimal | Loss | Tỷ lệ hao hụt chưa giải thích | Formula | Recalculate | |
| 38 | Month | Month | Integer | Time | Tháng | Hardcoded Value | Review | |
| 39 | Year | Year | Integer | Time | Năm | Hardcoded Value | Review | |
