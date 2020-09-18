#!/bin/bash
x="teste"
menu ()
{
      while true $x != "teste"
      do
            clear
            echo "================================================"
            echo "Robot Applications"
            echo "Created by LAI9 - QA Team"
            echo ""
            echo "0) Install Robot LA Innovation Framework (MANDATORY for the first time)"
            echo ""
            echo "1) Runs RAI9 - V1.3.R (Test by Request FASTER!)"
            echo ""
            echo "2) Runs RAI9 - V1.3.C (Test by Command Line SLOWER)"
            echo ""
            echo "3) Runs RWI9 - V0.1 (Under development)"
            echo ""
            echo "4) Quit"
            echo ""
            echo "For any issues or new features check: https://github.ibm.com/la-innovation/qa_initiative"
            echo "================================================"
            echo "Please, select your option:"
            read x

case "$x" in
      0)
      echo "Press ENTER to install."
      read -r
      cd ~/Documents/robot/source || exit
      bash ./installation.sh
      ;;

      1)
      echo "Running RAI9 - V1.3.R"
      echo "Make sure that the installation is already executed (Option 0)."
      echo "Press ENTER to continue or, close the app then run the install."
      read -r
      cd ~/Documents/robot || exit
      robot -d ./log -T ./suites/api_request_test.robot
      Sleep 5
      exit;
      echo "================================================"
      ;;
      
      2)
      echo "Running RAI9 - V1.3.C"
      echo "Make sure that the installation is already executed (Option 0)."
      echo "Press ENTER to continue or, close the app then run the install."
      read -r
      cd ~/Documents/robot || exit
      robot -d ./log -T ./suites/api_command_line_test.robot
      Sleep 5
      exit;
      echo "================================================"
      ;;
      
      3)
      echo "This part is not develop yet, check our git page for more information."
      read -r
      echo "================================================"
      ;;
      
      4)
      echo "Thanks..."
      read -p "Press ENTER to continue."
      clear;
      exit;
      echo "================================================"
      ;;

      *)
      echo "Invalid Option! Select a valid one."
      read -p "Press ENTER to continue."
esac
done

}
menu
