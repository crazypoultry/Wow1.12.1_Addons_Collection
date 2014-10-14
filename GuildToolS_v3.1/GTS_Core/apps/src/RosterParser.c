//RosterParser v3.1 part of
//GuildToolS package v3.1
//Parses the data saved by GTS_GuildRosterScaner into html format
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

int RosterParser(int argc, char **argv){
  //temp variables
  int i, l=0, desc_len=0;
  char buf[10000], tmp[150];
  char head[30000], tail[30000], link[50000];
  //pipes
  FILE *in, *out;
  //global variables
  int newowner = 0, prevowner=0;
  //roster
  char clas[20], name[20], rank[20], prof1[50], prof2[50], guild[40], main[30];
  int level, rankNum, prof1lvl, prof2lvl;
  struct guild guilds[10];
  int numguilds = 0;
  //config variables
  int PHP = 0;
  char VER[7]="3.1";
  char TITLE[21]="My guild roster.";
  char STDIMAGESFOLDER[101]="images/";
  char LUAFILE[101]="../SV/GTS_Core.lua";
  char OUTPUT[101]="../html/roster.html";
  
  head[0]= '\0';
  tail[0]= '\0';
  link[0]= '\0';

  //Slash handler
  for (i=1; i<argc; i++)
  {
    if (strcmp(argv[i],"-t")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>20) argv[i+1][20]=0;
      strncpy(TITLE, argv[i+1], strlen(argv[i+1]));
      TITLE[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-sif")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(STDIMAGESFOLDER, argv[i+1], strlen(argv[i+1]));
      STDIMAGESFOLDER[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-i")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(LUAFILE, argv[i+1], strlen(argv[i+1]));
      LUAFILE[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-o")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(OUTPUT, argv[i+1], strlen(argv[i+1]));
      OUTPUT[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-?")==0 || strcmp(argv[i],"-help")==0)
    {
      printf("\nRosterParser v%s \nParses the data saved in SavedVariables.lua by GTS_GuildRosterScaner into html format.\n\n", VER);
      printf("Any of the flags can be used in any order.\n");
      printf("If flag is used more than once in one statement last inputed value will be used\n");
      printf("'\"' character cannot be used in strings.\n");
      printf("If your string has spaces in it put it in \" \" Ex: '-t \"My guild\"'.\n");
      printf("\"\" sharacters are not necessary around a string statement if your string does\n");
      printf(" not contain spaces.\n\n");
      printf("Advanced mode flags:\n\n");
      printf("-t <string>    - Title. Set the title of the page and Bag name to the string\n");
      printf("                  passed.\n");
      printf("                 Ex: '-t \"Guild\"'.\n");
      printf("                 Default: '%s'.\n",TITLE);
      printf("                 Max string length is 20 chars.\n");
      printf("-sif <string>  - Standart Images foulder. Sets the folder where the built-in\n");
      printf("                  images will be taken from. (those .gif that are supplied)\n");
      printf("                 Ex: '-if http://www.somesite.com/images/'.\n");
      printf("                 Default: '%s'.\n",STDIMAGESFOLDER);
      printf("                 Max string length is 100 chars.\n");
      printf("-i <string>    - Input. Path to the input file (SavedVariables.lua).\n");
      printf("                 Ex: '-i \"../../WTF/Account/MyAccount/SavedVariables.lua\"'.\n");
      printf("                 Default: '%s'.\n",LUAFILE);
      printf("                 Max string length is 100 chars.\n");
      printf("-o <string>    - Output. Path to output file.\n");
      printf("                 Ex: '-o c:/mywebpage/guildroster.html'.\n");
      printf("                 Default: '%s'.\n",OUTPUT);
      printf("                 Max string length is 100 chars.\n");
      printf("\nCall Ex: 'parser -t \"Guild Roster\" -o ./roster.html'.\n");
      return 0;
    }
    printf("Improper use of arguments: check help (-?) for proper arguments list.\n");
    return 1;
  }

  printf("\nRosterParser v%s \nParses the data saved in SavedVariables.lua by GTSGuildRosterScaner into html format.\n\n", VER);

  if (argc>1)
  {
    printf("   ******    Advanced mode.   *******\n\n");
    printf("Title:                    '%s'\n",TITLE);
    printf("Location of input file:   '%s'\n",LUAFILE);
    printf("Output output html file:  '%s'\n\n",OUTPUT);
    printf("   **********************************\n\n");
  }

  //Open SavedVariables.lua file for reading
  printf("Opening %s for read ... ", LUAFILE);
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not find input file. Make sure that you specified proper file.\n");
    else fprintf(stderr,"Failed.\n   Reson: Could not find input file. Make sure that you copied SavedVaribles.lua to the AddOn folder.\n");
    return 1;
  }else printf("Ok.\n");
  //Create and open .html for write
  printf("Opening %s for write ... ", OUTPUT);
  if ((out=fopen(OUTPUT,"wt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not create output file. Make sure that you specified proper file.\n");
    else fprintf(stderr, "Failed.\n   Reson: Could not create output file (%s). Make sure you have permision to create files.\n", OUTPUT);
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
  
  //Make string with constant html text (begining and end)
  strcat(tail,"  </table>\n");
  if (PHP == 0)
  {
    strcat(head,"<html>\n\n<head>\n<title>");
    strcat(head,TITLE);
    strcat(head,"</title>\n</head>\n");
    strcat(head,"<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">\n");
    strcat(head,"\n<body lang=EN-US>\n");
    
    strcat(tail,"<p>\n<span style=\"font-size: 12px; color: #5F5F5F;\">This page was generated by ");
    strcat(tail,"<a href=\"http://www.curse-gaming.com/mod.php?addid=1899\">");
    strcat(tail,"(GTS)GuildRosterScaner v");
    strcat(tail, VER);
    strcat(tail,"</a>. Best viewed under IE 5+.</span>\n</body>\n\n</html>");
  }
  
  
  if (PHP == 0) fprintf(out, head);
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
         
         //Reads the info of guild members
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
               //Read the name of the char
               strncpy(guild, tmp+2, strlen(tmp)-4);
               guild[strlen(tmp)-4] = '\0';
               tmp[0]='\0';
               newowner=1;
               fscanf(in, " = { %s", buf);
               
               //Reset all the storage vars for char info before scanning
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
               
               //Scan char info
               while (strncmp(buf, "},", 2)!=0)
               {
                 if (newowner==1)
                 {
                   newowner=0;
                   link[0]='\0';
                   //Table wrapper
                   if (prevowner == 1)
                   {
                     strcat(tail,"  </table>\n");
                     
                     strcat(link,"<!--               NEXT           -->\n");               
                   }
                   strcat(link,"  <p>");
                   strcat(link,guild);
                   strcat(link,"</p>\n");
                   strcat(link,"  <table width=600 bordercolor='#000000'");
                   strcat(link," border=1 cellspacing=0 cellpadding=5>\n");
                   strcat(link,"  <tr bgcolor='#888888'>\n  <td width=50 align=center valign=top>\n");
                   strcat(link,"   Class\n  </td>\n");
                   strcat(link,"  <td width=50 align=center valign=top>\n");
                   strcat(link,"   LvL\n  </td>\n");
                   strcat(link,"  <td width=100 align=center valign=top>\n");
                   strcat(link,"   Name\n  </td>\n");
                   strcat(link,"  <td width=100 align=center valign=top>\n");
                   strcat(link,"   Rank\n  </td>\n");
                   strcat(link,"  <td width=300 align=center valign=top>\n");
                   strcat(link,"   Proffessions\n  </td>\n </tr>\n");
                   prevowner = 1;
                   fprintf(out, link);
                   link[0]='\0';         
                 }
                 
                 //Actual char scan
                 //Class
                 if (strncmp(buf, "[\"class\"]", 10)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(clas, buf, strlen(buf)+1);
                 }
                 //Level
                 if (strncmp(buf, "[\"level\"]", 9)==0)
	             {
	               fscanf(in, " = \" %d \",", &level);
                 }
                 //Rank number
                 if (strncmp(buf, "[\"rankNum\"]", 12)==0)
	             {
	               fscanf(in, " = \" %d \",", &rankNum);
                 }
	             //Rank
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
	             //Main-alt relation
	             if (strncmp(buf, "[\"main\"]", 8)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(main, buf, strlen(buf)+1);
	             }
	             //Name
	             if (strncmp(buf, "[\"name\"]", 8)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(name, buf, strlen(buf)+1);
	             }
	             //Profession 1
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
	             //Profession 2
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
                 //Profession 1 level
                 if (strncmp(buf, "[\"prof1lvl\"]", 12)==0)
	             {
	               fscanf(in, " = \" %d \",", &prof1lvl);
                 }
                 //Profession 2 level
                 if (strncmp(buf, "[\"prof2lvl\"]", 12)==0)
	             {
	               fscanf(in, " = \" %d \",", &prof2lvl);
                 }
                 //End of variables list
                 
                 fscanf(in, "%s", buf);
                 //If all the variables have been scanned for this char - 
                 //put them into html file
                 if (strncmp(buf, "},", 2)==0 && name[0]!='\0')
                 {
                   link[0]='\0';
                   if (strcmp(main,"1")==0) l++;
                   strcat(link," <tr bgcolor='#");
                   if ((l%2)==1) strcat(link, "FFFFFF'>\n");
                   else strcat(link,"EEEEEE'>\n");
                   strcat(link,"  <td width=50 align=center valign=top>");
                   strcat(link,"<img src=\"");
                   strcat(link,STDIMAGESFOLDER);
                   strcat(link,clas);
                   if (strcmp(main,"1")==0) strcat(link,".gif\">");
                   else strcat(link,".gif\" width=32 height=30>");
                   strcat(link,"  <td width=50 align=center valign=middle>");
                   if (strcmp(main,"1")==0) strcat(link,"<span style=\"font-size: 16px;\">");
                   else strcat(link,"<span style=\"font-size: 12px;\">");
                   sprintf(buf, "%d", level);
                   strcat(link,buf);
                   strcat(link,"</span>");
                   strcat(link,"  </td>\n  <td width=100 align=left valign=middle>");
                   if (strcmp(main,"1")==0) strcat(link,"<span style=\"font-size: 16px;\">");
                   else strcat(link,"<span style=\"font-size: 12px;\">");
                   strcat(link,name);
                   strcat(link,"</span>");
                   strcat(link,"  </td>\n  <td width=100 align=center valign=middle>");
                   if (strcmp(main,"1")==0) strcat(link,"<span style=\"font-size: 16px;\">");
                   else strcat(link,"<span style=\"font-size: 12px;\">");
                   strcat(link,rank);
                   strcat(link,"</span>");
                   strcat(link,"  </td>\n  <td width=300 align=letf valign=middle>");
                   if (strcmp(main,"1")==0) strcat(link,"<span style=\"font-size: 16px;\">");
                   else strcat(link,"<span style=\"font-size: 12px;\">");
                   strcat(link,prof1);
                   if (prof1lvl > 0)
                   {
                     sprintf(buf, " %d", prof1lvl);
                     strcat(link, buf);             
                   }
                   strcat(link," / ");
                   strcat(link,prof2);
                   if (prof2lvl > 0)
                   {
                     sprintf(buf, " %d", prof2lvl);
                     strcat(link, buf);             
                   }
                   if (strcmp(main,"1")!=0)
                   {
                     strcat(link, ", alt of ");
                     strcat(link, main);             
                   }
                   strcat(link,"</span>");
                   strcat(link,"  </td>\n  </tr>\n");
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
  
  fprintf(out, tail);
  fclose(in);
  fclose(out);
  return 0; 
}
