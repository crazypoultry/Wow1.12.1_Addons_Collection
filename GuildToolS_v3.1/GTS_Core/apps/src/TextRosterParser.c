//TextRosterParser v3.1 part of
//GuildToolS package v3.1
//Parses the data saved by GTS_GuildRosterScaner into text format
// - Guild roster
//
//Author: Roman Tarakanov (RTE/Arthas)
//Date: Aug 21 '06

#include <stdio.h>
#include <string.h>

//guild structure
struct guild {
  char name[20];
  char date[20];
};

int TextRosterParser(int argc, char **argv){
  //temp variables
  int i;
  char buf[10000], tmp[150];
  char link[50000];
  //pipes
  FILE *in, *out;
  //global variables
  int newowner = 0;
  //roster
  char clas[20], name[20], rank[20], prof1[50], prof2[50], guild[40], main[30];
  int level, rankNum, prof1lvl, prof2lvl;
  struct guild guilds[10];
  int numguilds = 0;
  //config variables
  char VER[7]="3.1";
  char LUAFILE[101]="../SV/GTS_Core.lua";
  char OUTPUT[101]="./roster.dat";
  
  link[0]= '\0';

  if (argc > 1)
  {
    printf("\nTextRosterParser v%s \nParses the data saved in SavedVariables.lua by GTS_GuildRosterMail into text format.\n\n", VER);
  } else {
    printf("\nTextRosterParser v%s \nParses the data saved in SavedVariables.lua by GTS_GuildRosterMail into text format.\n\n", VER);
    printf("Takes string as parameter.\n");
    printf("String can contain any text. \n\%<char> combinations will be raplaced by representative strings.\n");
    printf("Parser will generate output file acording to the schema provided.\n");
    printf("\%");printf("n - \'name\', name of the member.\n");
    printf("\%");printf("c - \'class\', class of the member.\n");
    printf("\%");printf("l - \'level\', level of the member.\n");
    printf("\%");printf("r - \'rank\', rank of the member.\n");
    printf("\%");printf("m - \'main\', name of the main of the member (1 if this is a main).\n");
    printf("\%");printf("a - \'rank number\', rank number of the member.\n");
    printf("\%");printf("1 - \'profession 1\', first profession of the member.\n");
    printf("\%");printf("2 - \'profession 2\', second profession of the member.\n");
    printf("\%");printf("9 - \'level of prof1\', level of the first profession of the member.\n");
    printf("\%");printf("0 - \'level of prof2\', level of the second profession of the member.\n");
    

    printf("\nEx: \"TextRosterParser insert into Table values ( \%");printf("n , \%");printf("a )\" will produce file\n");
    printf("%s, where every row will look like \n\"insert into Table values ( '<name>' , '<#>' )\".\n", OUTPUT);

    return 0;
  }

  //Open SavedVariables.lua file for reading
  printf("Opening %s file for read ... ", LUAFILE);
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not find input file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not find input file. Make sure that you copied SavedVaribles.lua to the AddOn folder.\n");
    return 1;
  }else printf("Ok.\n");
  //Create and open .html for write
  printf("Opening %s file for write ... ", OUTPUT);
  if ((out=fopen(OUTPUT,"wt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not create output file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not create output file (%s). Make sure you have permision to create files.\n", OUTPUT);
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
    //Make sure there is data in file
  printf("Checking for data availability (GTS_Data) ... ");
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"GTS_Data",9)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"GTS_Data",9) != 0)
  {
    printf("Failed.\n   Reson: Necessaryata was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  printf("Checking for data entry (GRS) ... ");
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"GRS\"]",7)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"[\"GRS\"]",7) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  

  
  // ---------------- GRS data ------------------
    if (strncmp(buf,"[\"GRS\"]",8) == 0) 
    {  
       fscanf(in, "%s", buf);
       while (strncmp(buf, "},", 2)!=0)
       { 
         //Reads the date scanned for all guilds
         if (strncmp(buf,"[\"Date\"]",8)==0) 
         {
           while (strncmp(buf,"{",1)!=0) fscanf(in,"%s",buf);
           fscanf(in,"%s",buf);
           
           while (strncmp(buf, "},", 2)!=0)
           {
             char name[20],date[20];
             tmp[0] = '\0';
             strcpy(tmp, buf);
             while (strstr(tmp,"[\"")==NULL || strstr(tmp,"\"]")==NULL) 
             {
                     
               fscanf(in, "%s", buf);
               strcat(tmp, " ");
               strcat(tmp, buf);     
             }
             strcpy(buf, tmp);
             //Read the date of last parse
             fscanf(in, " = \" %s \",", date);
             //Read the name of bank char
             if (strstr(buf,"[\"")!=NULL && strstr(buf,"\"]")!=NULL)
             {
               strncpy(name, buf+2, strlen(buf)-4);
               name[strlen(buf)-4] = '\0';
             }
             for (i=0; i<numguilds; i++)
             {
               if (strcmp(name, guilds[i].name) == 0)
               {
                 strcpy(guilds[i].date, date);
                 break;
               }
             }
             if (strcmp(name, guilds[i].name) != 0)
             {
               strcpy(guilds[numguilds].date, date);
               strcpy(guilds[numguilds].name, name);   
               numguilds++;            
             }
             fscanf(in, "%s", buf);
           }  
         }
         
         //Reads the items in posession of bank characters
         if (strncmp(buf,"[\"GuildRoster\"]",17)==0) 
         {
           fscanf(in, "%s", buf);
           while (strncmp(buf, "}", 1)!=0)
           {
             if (strstr(buf,"[\"")==NULL) 
               fscanf(in, "%s", buf);
             if (strstr(buf,"[\"")!=NULL)
             {
               tmp[0] = '\0';
               strcpy(tmp, buf);
               while (strstr(tmp,"[\"")==NULL || strstr(tmp,"\"]")==NULL) 
               {
                 
                 fscanf(in, "%s", buf);
                 strcat(tmp, " ");
                 strcat(tmp, buf);    
               }
               //Read the name of bank char
               strncpy(guild, tmp+2, strlen(tmp)-4);
               guild[strlen(tmp)-4] = '\0';
               tmp[0]='\0';
               newowner=1;
               fscanf(in, " = { %s", buf);
               
               //Reset all the starage vars for item info before scanning
               level = 0;
               rankNum = 0;
               main[0] = '\0';
               prof1lvl = 0;
               prof2lvl = 0;
               clas[0] = '\0';
               rank[0] = '\0';
               name[0]='\0';
               prof1[0]='\0';
               prof2[0]='\0';
               
               //Scan item's info
               while (strncmp(buf, "},", 2)!=0)
               {
                 //Clear old data for this bunk char in DB
                 if (newowner==1)
                 {
                   link[0]='\0';         
                 }
                 
                 //Actual item's scan
                 //Quantity
                 if (strncmp(buf, "[\"class\"]", 10)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(clas, buf, strlen(buf)+1);
                 }
                 //Price
                 if (strncmp(buf, "[\"level\"]", 9)==0)
	             {
	               fscanf(in, " = \" %d \",", &level);
                 }
                 //Mail id
                 if (strncmp(buf, "[\"rankNum\"]", 12)==0)
	             {
	               fscanf(in, " = \" %d \",", &rankNum);
                 }
	             //Item ID
	             if (strncmp(buf, "[\"rank\"]", 8)==0)
	             {
                   fscanf(in, " = \" %s", buf);
                   while (strncmp(buf, "\",", 2)!=0)
                   {
                     if (rank[0]!='\0')
                     {
                       strncat(rank, " ", 1);
                     }
                     strncat(rank, buf, strlen(buf)+1);
                     fscanf(in, "%s", buf);
                   }
	             }
	             //Quality
	             if (strncmp(buf, "[\"main\"]", 8)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(main, buf, strlen(buf)+1);
	             }
	             //Icon
	             if (strncmp(buf, "[\"name\"]", 8)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(name, buf, strlen(buf)+1);
	             }
	             //Date
	             if (strncmp(buf, "[\"prof1\"]", 9)==0)
	             {
	               fscanf(in, " = \" %s", buf);
	               while (strncmp(buf, "\",", 2)!=0)
	               {
	                 strncat(prof1, buf, strlen(buf)+1);
	                 strcat(prof1," ");
	                 fscanf(in, "%s", buf);
                   }
                 }
	             //Sender
	             if (strncmp(buf, "[\"prof2\"]", 9)==0)
	             {
	               fscanf(in, " = \" %s", buf);
	               while (strncmp(buf, "\",", 2)!=0)
	               {
	                 strncat(prof2, buf, strlen(buf)+1);
	                 strcat(prof2," ");
	                 fscanf(in, "%s", buf);
                   }
                 }
                 //Price
                 if (strncmp(buf, "[\"prof1lvl\"]", 12)==0)
	             {
	               fscanf(in, " = \" %d \",", &prof1lvl);
                 }
                 //Mail id
                 if (strncmp(buf, "[\"prof2lvl\"]", 12)==0)
	             {
	               fscanf(in, " = \" %d \",", &prof2lvl);
                 }
	             
                 //End of variables list
                 
                 fscanf(in, "%s", buf);
                 //If all the variables have been scanned for this item - 
                 //send them to the DB
                 if (strncmp(buf, "},", 2)==0 && name[0]!='\0')
                 {
                   
                   
                   //Creates an sql statement to add the item into DB
                   link[0]='\0';
                   for (i=1; i<argc; i++)
                   {
	                 if (argv[i][0] == '%')
                     {
                       strcat(link, "'");
	                   if (argv[i][1] == 'n') strcat(link, name);
	                   if (argv[i][1] == 'r') strcat(link, rank);
	                   if (argv[i][1] == 'l') { sprintf(tmp, "%d", level); strcat(link, tmp); }
	                   if (argv[i][1] == 'c') strcat(link, clas);
	                   if (argv[i][1] == 'm') strcat(link, main);
	                   if (argv[i][1] == 'a') { sprintf(tmp, "%d", rankNum); strcat(link, tmp); }
	                   if (argv[i][1] == '1') strcat(link, prof1);
	                   if (argv[i][1] == '2') strcat(link, prof2);
	                   if (argv[i][1] == '9') { sprintf(tmp, "%d", prof1lvl); strcat(link, tmp); }
	                   if (argv[i][1] == '0') { sprintf(tmp, "%d", prof2lvl); strcat(link, tmp); }
	                   
                       strcat(link, "' ");
                     } else {
	                 strcat(link, argv[i]);
                     strcat(link, " ");
                     }
                   }
                   strcat(link, "\n");
                   
                   fprintf(out, link);
                   //reset store variables for the next scan
                   level = 0;
                   rankNum = 0;
                   main[0] = '\0';
                   prof1lvl = 0;
                   prof2lvl = 0;
                   clas[0] = '\0';
                   rank[0] = '\0';
                   name[0]='\0';
                   prof1[0]='\0';
                   prof2[0]='\0';
                   //l++;
                   
                   fscanf(in, "%s", buf);
                 }
               }               
             }
             fscanf(in, "%s", buf);
		   }  
         }
         fscanf(in, "%s", buf);
       }                        
    }
  
  fclose(in);
  fclose(out);
  return 0; 
}
