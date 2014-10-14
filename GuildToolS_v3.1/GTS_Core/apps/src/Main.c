//GuildToolS package v3.1
//Tools for guild use to manage bank characters
// and guild as a whole.
//Collection of parsers for GTS WoW AddOn
//
//Author: Roman Tarakanov (RTE/Arthas)
//Date: Aug 21 '06

#include <stdio.h>

int main(int argc, char **argv)
{
  char* VER = "3.1";
  
  printf("\nGuildToolS v%s parser.\n-----------------------------------------------------\n",VER);
  if (argc < 2)
  {
    printf("\nInvalid input.\nYou must specify at least one option.\n");
    printf("See -help for all options.\n");
    return 1;
  }
  if (strncmp(argv[1],"-help",6)==0 || strncmp(argv[1],"-?",3)==0)
  {
    printf("\nAvailable commands:\n");
    printf("-upload     - Uploads all the data to the GBM server.\n");
    printf("              See '-upload -help' for details.\n");
    printf("-textupload - Generates flat files for upload to GBM server.\n");
    printf("              See '-textupload -help' for details.\n");
    printf("-bank       - Generates html file with the content of the bank.\n");
    printf("              See '-bank -help' for details.\n");
    printf("-textbank   - Generates text file with the content of the bank with user\n");
    printf("               specified format.\n");
    printf("              See '-textbank' for details.\n");
    printf("-imail      - Generates html file with the list of received items.\n");
    printf("              See '-imail -help' for details.\n");
    printf("-textimail  - Generates text file with the list of received items with user\n");
    printf("               specified format.\n");
    printf("              See '-textimail' for details.\n");
    printf("-omail      - Generates html file with the list of sent items.\n");
    printf("              See '-imail -help' for details.\n");
    printf("-textomail  - Generates text file with the list of sent items with user\n");
    printf("               specified format.\n");
    printf("              See '-textimail' for details.\n");
    printf("-roster     - Generates html file with the list of guild members.\n");
    printf("              See '-roster -help' for details.\n");
    printf("-textroster - Generates text file with the list of guild members with user\n");
    printf("               specified format.\n");
    printf("              See '-textroster' for details.\n");
    return 0;
  }
  if (strncmp(argv[1],"-upload",7)==0)
    return GBMupload(argc-1, argv+1);
  if (strncmp(argv[1],"-textupload",11)==0)
    return GBMtextupload(argc-1, argv+1);
  else if (strncmp(argv[1],"-bank",7)==0)
    return BankParser(argc-1, argv+1);
  else if (strncmp(argv[1],"-textbank",11)==0)
    return TextBankParser(argc-1, argv+1);
  else if (strncmp(argv[1],"-imail",7)==0)
    return IMailParser(argc-1, argv+1);
  else if (strncmp(argv[1],"-textimail",11)==0)
    return TextIMailParser(argc-1, argv+1);
  else if (strncmp(argv[1],"-omail",7)==0)
    return OMailParser(argc-1, argv+1);
  else if (strncmp(argv[1],"-textomail",11)==0)
    return TextOMailParser(argc-1, argv+1);
  else if (strncmp(argv[1],"-roster",8)==0)
    return RosterParser(argc-1, argv+1);
  else if (strncmp(argv[1],"-textroster",12)==0)
    return TextRosterParser(argc-1, argv+1);  
  else
    printf("\nNot a valid comand.\nSee '-help' for the list of valid comands.\n");
  return 1;    
}
