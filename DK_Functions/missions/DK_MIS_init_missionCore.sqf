if !(isServer) exitWith {};

DK_idMission = "0";
DK_MIS_tgMarkers = [];


// Очередь JIP для клиента миссии NFO
DK_MIS_IdJIP_initCL = "DK_JipMisId";

// Время выполнения/завершения миссии
DK_MIS_maxTimeMission = 1800;	// 900 : 15 мин

// Параметры времени для удаления трупов миссии, второстепенных подразделений и техники
DK_MIS_timeDelCorps = 90;
DK_MIS_disDelCorps = 100;

DK_MIS_timeDelScdrU = 0;
DK_MIS_disDelScdrU = 50;

DK_MIS_timeDelScdrU2 = 180;
DK_MIS_disDelScdrU2 = 700;

DK_MIS_timeDelVeh = 90;
DK_MIS_disDelVeh = 100;

DK_MIS_timeDelProps = 60;
DK_MIS_disDelProps = 200;

DK_MIS_timeDelRescueVeh = 120;
DK_MIS_disDelRescueVeh = 50;

DK_MIS_timeDelRewards = 180;
DK_MIS_disDelRewards = 200;

// Оценка параметров, связанные с целевыми и вторичными единицами
DK_scrThug = 20;
DK_scrLooter = 20;
DK_scrBallas = 30;
DK_scrTriads = 30;
DK_scrDomi = 40;
DK_scrAlban = 40;

DK_scrPolice = 20;
DK_scrFBI = 35;
DK_scrArmy = 50;

DK_scrVIPciv = 245;
DK_scrVIPmed = 350;
DK_scrVIPcop = 450;
DK_scrVIPalba = 500;
DK_scrVIPdomi = 500;
DK_scrVIParmy = 800;

DK_scrThugScd = 1;
DK_scrLooterScd = 1;
DK_scrBallasScd = 2;
DK_scrTriadsScd = 2;
DK_scrDomiScd = 3;
DK_scrAlbanScd = 3;

DK_scrPoliceScd = 2;
DK_scrFBIScd = 4;
DK_scrArmyScd = 8;

DK_scrDisTC = 15;
DK_scrOffroadTC = 100;
DK_scrSuvTC = 125;
DK_scrJeepTC = 125;
DK_scrHatchTC = 150;
DK_scrHatchSpTC = 100;


// Получить параметры миссии
DK_MIS_var_missInProg = false;
DK_timeBetweenMissions = "Par_timeBetweenMissions" call BIS_fnc_getParamValue;

// Количество выполненных миссий
DK_nbMisCpltd = 0;


// Поиск места для подкрепления (для безопасного появления техники в том же месте)
DK_nbSearchSpawnRoad_inProg = false;
DK_nb_searchSpawn_rfr_heli_inProg = false;

// Память на порядок размещения реквизитов в миссии
DK_MIS_Kill_01_props_select_Init = [1, 2, 3, 4, 6];
DK_MIS_Kill_01_props_select = +DK_MIS_Kill_01_props_select_Init;


/// Выберите миссию, сложность и место
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\selectMission\DK_MIS_fncs_missionSelection.sqf";

/// Компиляция ядра
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\DK_MIS_fncs_missionsCore.sqf";

/// Компиляция миссий
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\missions_Kill\DK_MIS_fncs_Kill_01.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\missions_Kill\DK_MIS_fncs_Kill_02.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\missions_Kill\DK_MIS_fncs_Kill_03.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\missions_Kill\DK_MIS_fncs_Kill_04.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\missions_Kill\DK_MIS_fncs_Kill_05.sqf";
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\missions_TakeCar\DK_MIS_fncs_TakeCar_01.sqf";
call DK_MIS_TakeCar_01_hideObjectAtShedSmall;

/// Компиляция загрузки
call compileFinal preprocessFileLineNumbers "DK_Functions\missions\loadouts\DK_MIS_fnc_loadouts.sqf";

/// Запустить цикл управления
[] execVM "DK_Functions\missions\DK_MIS_loop_setUnitPosUP.sqf";
//[] execVM "DK_Functions\missions\DK_MIS_loop_OnOffRespawn.sqf";//???


