# microarchitecture-RISC-V
В репозитории представлены файлы исходников микроархитектуры конвейерного процессора, совместимого с набором инструкций RV32I.
Конвейер содержит 5 стадий: Fetch, Decode, Execute, Memory и Writeback. 
Ниже в таблицах представлены модули, которые содержатся в каждой стадии, а также файлы модулей с кратким описанием функционала.
На стадии Writeback осуществляется направление данных для записи в RegisterFile.
| Стадия                     | Модули |
| -------------              |:-------------|
| Fetch                      | InstructionsMemory                            |  
| Decode                     | ControlUnit, RegisterFile, ImmediateExtension |
| Execute                    | ALU, BranchUnit                               |
| Memory                     | SPartWord, DataMemory, LPartMemory            |

| Файл                       | Описание файла |
| -------------              |:-------------|
| InstructionsMemory.sv      | Модуль памяти инструкций  |  
| RegisterFile.sv            | Модуль, содержащий 32 регистра |  
| ControlUnit.sv             | Модуль, генерирующий в зависимости от типа инструкции управляющие сигналы для мультиплексоров и других модулей по всему тракту данных |  
| ImmediateExtension.sv      | Модуль расширения констант   |  
| BranchUnit.sv              | Модуль, определяющий, нужно ли совершать переход при выполнении B-инструкции |
| ALU.sv                     | Арифметико-логическое устройство. Совершает операции с данными из регистров и константами |
| DataMemory.sv              | Модуль памяти данных |
| LPartWord.sv               | Модуль, определяющий длину слова, загружаемого в регистр из памяти (инструкции lw, lh, lb, lwu, lhu, lbu)  |
| SPartWord.sv               | Модуль, определяющий длину слова, сохраняемого в память из регистра (инструкции sw, sh, sb) |
| TractF.sv                  | Тракт данных стадии Fetch |
| TractD.sv                  | Тракт данных стадии Decode|
| TractE.sv                  | Тракт данных стадии Execute|
| TractM.sv                  | Тракт данных стадии Memory|
| TractW.sv                  | Тракт данных стадии Writeback|
| Tract.sv                   | Общий тракт данных процессора, в котором тракты стадий соединены регистрами|
| ConflictPreventionUnit.sv  | Блок разрешения конфликтов |
| RISCVConv.sv               | Модуль, соединяющий блок разрешения конфликтов и тракт данных |
| DUT.sv                     | Top-level иерархии, содержит экземпляр модуля ядра процессора. Создан для тестов (будут написаны в будущем) |





