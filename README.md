# 🚦 GateWiz - Traffic Light Controller for Highway-Farm Intersection

## 📌 Problem Statement

Design a **traffic light controller** using **Verilog** (for FPGA implementation) for an intersection between a **highway** and a **farm road**, where the **highway has higher priority**.

The controller must:
- Keep the **highway light green by default**.
- Use a **vehicle sensor** (`C`) to detect cars on the farm road.
- Transition lights safely and efficiently when a vehicle is detected.
- Introduce **realistic timing delays** to simulate proper traffic flow.

---

## ⚙️ Functional Description

### 🛣️ Default State
- **Highway Light**: Green  
- **Farm Road Light**: Red

### 🚗 Vehicle Detected on Farm Road
If a vehicle is detected on the farm road (`C = 1`):
1. The system changes highway light: **Green → Yellow → Red**
2. Farm road light turns: **Red → Green**
3. After a fixed delay, the system **reverts back to default** state.

---

## ⏱️ Timing Sequence

| State                         | Highway Light | Farm Road Light | Duration   |
|------------------------------|---------------|------------------|------------|
| `HGRE_FRED` (Default)        | Green         | Red              | Until vehicle detected |
| `HYEL_FRED` (Transition)     | Yellow        | Red              | 3 seconds |
| `HRED_FGRE` (Farm Green)     | Red           | Green            | 10 seconds |
| `HRED_FYEL` (Transition)     | Red           | Yellow           | 3 seconds |

---

## 🧠 FSM State Encoding

```verilog
parameter 
  HGRE_FRED  = 2'b00, // Highway Green, Farm Red
  HYEL_FRED  = 2'b01, // Highway Yellow, Farm Red
  HRED_FGRE  = 2'b10, // Highway Red, Farm Green
  HRED_FYEL  = 2'b11; // Highway Red, Farm Yellow
