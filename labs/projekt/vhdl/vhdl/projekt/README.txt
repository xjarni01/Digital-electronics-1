Obrazek enable:
Zacatek stmivani - okolo 1ms se zapne PWM stmivani (do te doby pwm_out = 0). PWM v simulaci je 4b registr, a zacne odcitat na zaklade count_out 20ti bitoveho signalu

![](vhdl/vhdl/enable.PNG)

Obrazek end_of_pwm:
V case 984ms PWM strida je 0%, a stmivani je ukonceno. Stmivac vyuziva horni bity pomaleho citace, tudiz zmenou velikosti citace se meni doba stmivani. Pro presnejsi PWM (8bitu, 16bitu) lze vzit vice nez jen horni ctyri bity citace.



Obecne poznamky:
Testbench je vytvoren pro system stmivani (fader_testb). Bohuzel jsmenestihli nasimulovat enkoder a casovac - je napsany, ale neotestovany
