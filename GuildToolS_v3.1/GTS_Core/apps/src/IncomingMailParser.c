#include <stdio.h>
//IncomingMailParser v3.1 part of
//GuildToolS package v3.1
//Parses the data saved by GTS_IncomingMail into html format
// - Inbox mail
//
//Author: Roman Tarakanov (RTE/Arthas)
//Date: Aug 21 '06

#include <string.h>

int IMailParser(int argc, char **argv){    
  //temp variables
  int i, l=0, desc_len=0;
  char buf[10000], tmp[150], tmp2[10];
  char head[30000], tail[30000], link[50000];
  //pipes
  FILE *in, *out;
  //global variables
  int newowner = 0, prevowner=0;
  //mail
  char num[100], name[100], desc[10000], pic[100], type[100], id[10], subtype[100], owner[20];
  char sender[20], date[20], sname[100];
  int quality, cost, minmailid, mailid;
  //config variables
  int PHP = 0;
  long WIDTH=15;
  char VER[7]="3.1";
  char TITLE[21]="My inbox";
  char SEARCHSITE[101]="http://www.thottbot.com/?s=";
  char IMAGESFOLDER[101]="images/";
  char STDIMAGESFOLDER[101]="images/";
  char IMAGEEXTENTION[11]=".jpg";
  char LUAFILE[101]="../SV/GTS_Core.lua";
  char OUTPUT[101]="../html/inbox.html";

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
    if (strcmp(argv[i],"-s")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(SEARCHSITE, argv[i+1], strlen(argv[i+1]));
      SEARCHSITE[strlen(argv[i+1])]=0;
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
    if (strcmp(argv[i],"-if")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(IMAGESFOLDER, argv[i+1], strlen(argv[i+1]));
      IMAGESFOLDER[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-ie")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>10) argv[i+1][10]=0;
      strncpy(IMAGEEXTENTION, argv[i+1], strlen(argv[i+1]));
      IMAGEEXTENTION[strlen(argv[i+1])]=0;
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
    if (strcmp(argv[i],"-php")==0)
    {
      PHP = 1;
      continue;
    }
    if (strcmp(argv[i],"-?")==0 || strcmp(argv[i],"-help")==0)
    {
      printf("\nIncomingMailParser v%s \nParses the data saved in SavedVariables.lua by GTS_IncomingMail into html format.\n\n", VER);
      printf("Any of the flags can be used in any order.\n");
      printf("If flag is used more than once in one statement last inputed value will be used\n");
      printf("'\"' character cannot be used in strings.\n");
      printf("If your string has spaces in it put it in \" \" Ex: '-t \"My donations\"'.\n");
      printf("\"\" sharacters are not necessary around a string statement if your string does\n");
      printf(" not contain spaces.\n\n");
      printf("Advanced mode flags:\n\n");
      printf("-t <string>    - Title. Set the title of the page and Bag name to the string\n");
      printf("                  passed.\n");
      printf("                 Ex: '-t \"Guild Bank\"'.\n");
      printf("                 Default: '%s'.\n",TITLE);
      printf("                 Max string length is 20 chars.\n");
      printf("-s <string>    - Searchsite. Sets the site that will be linked upon the click\n");
      printf("                  on the item. Resulting link will be: <string><name of the\n");
      printf("                  item '+' separated>.\n");
      printf("                 Ex: '-s http://www.mysite.com/?s='.\n");
      printf("                 Default: '%s'.\n",SEARCHSITE);
      printf("                 Max string length is 100 chars.\n");
      printf("-if <string>   - Images foulder. Sets the folder where the images will be\n");
      printf("                  taken from.\n");
      printf("                 Ex: '-if http://www.somesite.com/images/'.\n");
      printf("                 Default: '%s'.\n",IMAGESFOLDER);
      printf("                 Max string length is 100 chars.\n");
      printf("-sif <string>  - Standart Images foulder. Sets the folder where the built-in\n");
      printf("                  images will be taken from. (those .gif that are supplied)\n");
      printf("                 Ex: '-if http://www.somesite.com/images/'.\n");
      printf("                 Default: '%s'.\n",STDIMAGESFOLDER);
      printf("                 Max string length is 100 chars.\n");
      printf("-ie <string>   - Images extention. Sets the images extention.\n");
      printf("                 Ex: '-ie .jpg'.\n");
      printf("                 Default: '%s'.\n",IMAGEEXTENTION);
      printf("                 Max string length is 10 chars.\n");
      printf("-i <string>    - Input. Path to the input file (SavedVariables.lua).\n");
      printf("                 Ex: '-i \"../../WTF/Account/MyAccount/SavedVariables.lua\"'.\n");
      printf("                 Default: '%s'.\n",LUAFILE);
      printf("                 Max string length is 100 chars.\n");
      printf("-o <string>    - Output. Path to output file.\n");
      printf("                 Ex: '-o c:/mywebpage/guildbank.html'.\n");
      printf("                 Default: '%s'.\n",OUTPUT);
      printf("                 Max string length is 100 chars.\n");
      printf("-php           - generates only tables to the output file.\n");    
      printf("\nCall Ex: 'parser -t \"Recent Donations\" -o ./don.html -w 17 -ie \".jpg\"'.\n");
      return 0;
    }
    printf("Improper use of arguments: check help (-?) for proper arguments list.\n");
    return 1;
  }

  printf("\nIncomingMailParser v%s \nParses the data saved in SavedVariables.lua by GTS_IncomingMail into html format.\n\n", VER);

  if (argc>1)
  {
    printf("   ******    Advanced mode.   *******\n\n");
    printf("Title:                    '%s'\n",TITLE);
    printf("Link to the searchsite:   '%s<item name>'\n",SEARCHSITE);
    printf("Link to image:            '%s<name>%s'\n",IMAGESFOLDER,IMAGEEXTENTION);
    printf("Location of input file:   '%s'\n",LUAFILE);
    printf("Output output html file:  '%s'\n\n",OUTPUT);
    printf("   **********************************\n\n");
  }
  
  //Open SavedVariables.lua file for reading
  printf("Opening file %s to read data ... ", LUAFILE);
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    printf("Failed.\n   Reson: Could not find input file.\n");
    printf("          Make sure that you specified proper file.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  //Create and open index.html for write
  printf("Opening file %s for write ... ", OUTPUT);
  if ((out=fopen(OUTPUT,"wt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not create output file. Make sure that you specified proper file.\n");
    else fprintf(stderr, "Failed.\n   Reson: Could not create output file (./html/index.html). Make sure you have permision to create files.\n");
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
  
  printf("Checking for data entry (IM) ... ");
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"IM\"]",6)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"[\"IM\"]",4) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  //Make string with constant html text (begining and end)
  strcat(head,"<html>\n\n<head>\n<title>");
  strcat(head,TITLE);
  strcat(head,"</title>\n</head>\n");
  strcat(head,"<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">\n");
  strcat(head,"\n<body lang=EN-US>\n");
  
  strcat(tail,"	  </td>\n	 </tr>\n	</table>\n       </td>\n");
  strcat(tail,"       <td width=22 valign=top background = \"");
  strcat(tail, STDIMAGESFOLDER);
  strcat(tail, "bp022.gif\">\n");
  strcat(tail,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n   <tr>\n");
  strcat(tail,"    <td width=");
  sprintf(tmp,"%d",WIDTH*44+38);
  strcat(tail,tmp);
  strcat(tail," height=10 valign=top>\n");
  strcat(tail,"     <table width=");
  strcat(tail,tmp);
  strcat(tail," border=0 cellspacing=0 cellpadding=0>\n      <tr>\n");
  strcat(tail,"       <td width=55 height=10 valign=top valign=top align=center background = \"");
  strcat(tail, STDIMAGESFOLDER);
  strcat(tail, "bp030.gif\">\n       </td>\n");
  strcat(tail,"       <td width=");
  sprintf(tmp,"%d",WIDTH*44+38-55-50);
  strcat(tail,tmp);
  strcat(tail," height=10 valign=top align=center background = \"");
  strcat(tail, STDIMAGESFOLDER);
  strcat(tail, "bp031.gif\">\n       </td>\n");
  strcat(tail,"       <td width=50 height=10 valign=top valign=top align=center ");
  strcat(tail,"background = \"");
  strcat(tail, STDIMAGESFOLDER);
  strcat(tail, "bp032.gif\">\n");
  strcat(tail,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n");
  strcat(tail,"  </table>\n");
  if (PHP == 0)
  {
  strcat(tail,"<p>\n<span style=\"font-size: 12px; color: #5F5F5F;\">This page was generated by ");
  strcat(tail,"<a href=\"http://www.curse-gaming.com/mod.php?addid=1899\">");
  strcat(tail,"(GTS)IncomingMail v");
  strcat(tail, VER);
  strcat(tail,"</a>. Best viewed under IE 5+.</span>\n");
  strcat(tail,"</body>\n\n</html>");
  }
  
  if (PHP == 0) fprintf(out, head);
  // ---------------- IM data ------------------
    if (strncmp(buf,"[\"IM\"]",7) == 0) 
    {  
       fscanf(in, "%s", buf);
       while (strncmp(buf, "},", 2)!=0)
       { 
         if (strncmp(buf,"[\"GlobalID\"]",13)==0) 
         {
           while (strncmp(buf, "},",2)!=0) 
             fscanf(in, "%s", buf);                                                  
         }
         //Reads the items in posession of bank characters
         if (strncmp(buf,"[\"ReceivedItems\"]",18)==0) 
         {
           fscanf(in, "%s", buf);
           while (strncmp(buf, "}", 1)!=0)
           {
             if (strstr(buf,"[\"")==NULL || strstr(buf,"\"]")==NULL) 
               fscanf(in, "%s", buf);
             if (strstr(buf,"[\"")!=NULL && strstr(buf,"\"]")!=NULL)
             {
               //Read the name of bank char
               strncpy(owner, buf+2, strlen(buf)-4);
               owner[strlen(buf)-4] = '\0';
               newowner=1;
               fscanf(in, " = { %s", buf);
               
               //Reset all the starage vars for item info before scanning
               quality=0;
               cost = 0;
               mailid = 0;
               sender[0] = '\0';
               date[0] = '\0';
               name[0]='\0';
               sname[0]='\0';
               num[0]='\0';
               pic[0]='\0';
               desc[0]='\0';
               link[0]='\0';
               id[0] = '\0';
               type[0]='\0';
               subtype[0]='\0';
               minmailid = -1;
               
               //Scan item's info
               while (strncmp(buf, "},", 2)!=0)
               {
                 //Clear old data for this bunk char in DB
                 if (newowner==1)
                 {
                   newowner=0;
                   link[0]='\0';
                   //*********************************
                   if (prevowner == 1)
                   {
                     strcat(link,"	  </td>\n	 </tr>\n	</table>\n       </td>\n");
                     strcat(link,"       <td width=22 valign=top background = \"");
                     strcat(link, STDIMAGESFOLDER);
                     strcat(link, "bp022.gif\">\n");
                     strcat(link,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n   <tr>\n");
                     strcat(link,"    <td width=");
                     sprintf(tmp,"%d",WIDTH*44+38);
                     strcat(link,tmp);
                     strcat(link," height=10 valign=top>\n");
                     strcat(link,"     <table width=");
                     strcat(link,tmp);
                     strcat(link," border=0 cellspacing=0 cellpadding=0>\n      <tr>\n");
                     strcat(link,"       <td width=55 height=10 valign=top valign=top align=center background = \"");
                     strcat(link, STDIMAGESFOLDER);
                     strcat(link, "bp030.gif\">\n       </td>\n");
                     strcat(link,"       <td width=");
                     sprintf(tmp,"%d",WIDTH*44+38-55-50);
                     strcat(link,tmp);
                     strcat(link," height=10 valign=top align=center background = \"");
                     strcat(link, STDIMAGESFOLDER);
                     strcat(link, "bp031.gif\">\n       </td>\n");
                     strcat(link,"       <td width=50 height=10 valign=top valign=top align=center ");
                     strcat(link,"background = \"");
                     strcat(link, STDIMAGESFOLDER);
                     strcat(link, "bp032.gif\">\n");
                     strcat(link,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n");
                     strcat(link,"  </table>\n"); 
                     strcat(link,"<!--               NEXT           -->\n");               
                   }
                   strcat(link,"  <table width=");
                   sprintf(tmp,"%d",WIDTH*44+38);
                   sprintf(tmp2, "%d",WIDTH*44+38-150);
                   strcat(link,tmp);
                   strcat(link," border=0 cellspacing=0 cellpadding=0>\n   <tr>\n");
                   strcat(link,"    <td width=");
                   strcat(link,tmp);
                   strcat(link," height=48 valign=top>\n");
                   strcat(link,"     <table width=");
                   strcat(link,tmp);
                   strcat(link," border=0 cellspacing=0 cellpadding=0>\n");
                   strcat(link,"      <tr>\n       <td width=55 height=48 valign=top valign=top ");
                   strcat(link,"align=center background = \"");
                   strcat(link, STDIMAGESFOLDER);
                   strcat(link,"im010.gif\">\n       </td>\n");
                   strcat(link,"       <td width=");      
                   sprintf(tmp, "%d",WIDTH*44+38-55-50);
                   strcat(link, tmp);
                   strcat(link," height=48 valign=top align=center background = \"");
                   strcat(link, STDIMAGESFOLDER);
                   strcat(link,"bp011.gif\">\n");
                   strcat(link,"	<table width=* height=48 border=0 cellspacing=0 cellpadding=0>\n");
                   strcat(link,"	 <tr height=26>\n");
                   strcat(link,"	  <td width=");
                   strcat(link, tmp);
                   strcat(link," valign=bottom align=center>\n");
                   strcat(link,"	   <p><span style='color:white'>");
                   strcat(link,owner);
                   strcat(link,"</span></p>\n");
                   strcat(link,"	  </td>\n	 </tr>\n");
                   strcat(link,"	 <tr height=22>\n");
                   strcat(link,"	  <td width=\"200\" valign=bottom align=left>\n");
                   strcat(link,"	   <p><span style='color:white'>");
                   strcat(link,"</span></p>\n");
                   strcat(link,"	  </td>\n");
                   strcat(link,"	  <td width=");
                   strcat(link, tmp2);
                   strcat(link," valign=bottom align=right>\n");
                   strcat(link,"	   <p><span style='color:white'>");
                   strcat(link,"</span></p>\n");
                   strcat(link,"	  </td>\n	 </tr>\n");
                   strcat(link,"	</table>\n       </td>\n");
                   strcat(link,"       <td width=50 height=48 valign=top align=center ");
                   strcat(link,"background = \"");
                   strcat(link, STDIMAGESFOLDER);
                   strcat(link, "bp012.gif\">\n");
                   strcat(link,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n   <tr>\n");
                   strcat(link,"    <td width=");
                   sprintf(tmp,"%d",WIDTH*44+38);
                   strcat(link,tmp);
                   strcat(link," valign=top>\n     <table border=0 cellspacing=0 cellpadding=0>\n");
                   strcat(link,"      <tr>\n       <td width=16 valign=top background = \"");
                   strcat(link, STDIMAGESFOLDER);
                   strcat(link, "bp020.gif\">\n");
                   strcat(link,"       </td>\n       <td width=");
                   sprintf(tmp,"%d",WIDTH*44+38-16-22);
                   strcat(link, tmp);
                   strcat(link," valign=top background = \"");
                   strcat(link, STDIMAGESFOLDER);
                   strcat(link, "bp021.gif\">\n");
                   strcat(link,"	<table width=* border=0 cellspacing=0 cellpadding=0>\n	 <tr>\n");
                   strcat(link,"  <table width=660 bordercolor='#000000'");
                   strcat(link," border=1 cellspacing=0 cellpadding=5>\n");
                   strcat(link,"  <tr bgcolor='#201C19'>\n  <td width=40 align=center valign=top>\n");
                   strcat(link,"   <span style=\"color:white\">Item</span>\n  </td>\n");
                   strcat(link,"  <td width=260 align=center valign=top>\n");
                   strcat(link,"   <span style=\"color:white\">Description</span>\n  </td>\n");
                   strcat(link,"  <td width=100 align=center valign=top>\n");
                   strcat(link,"   <span style=\"color:white\">Cost</span>\n  </td>\n");
                   strcat(link,"  <td width=160 align=center valign=top>\n");
                   strcat(link,"   <span style=\"color:white\">Donated by</span>\n  </td>\n");
                   strcat(link,"  <td width=100 align=center valign=top>\n");
                   strcat(link,"   <span style=\"color:white\">Date</span>\n  </td>\n </tr>\n");
                   prevowner = 1;
                   fprintf(out, link);
                   link[0]='\0';         
                 }
                 
                 //Actual item's scan
                 //Quantity
                 if (strncmp(buf, "[\"number\"]", 10)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(num, buf, strlen(buf)+1);
                 }
                 //Price
                 if (strncmp(buf, "[\"price\"]", 9)==0)
	             {
	               fscanf(in, " = \" %d \",", &cost);
                 }
                 //Mail id
                 if (strncmp(buf, "[\"globalid\"]", 12)==0)
	             {
	               fscanf(in, " = \" %d \",", &mailid);
                 }
	             //Item ID
	             if (strncmp(buf, "[\"id\"]", 10)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(id, buf, strlen(buf)+1);
	             }
	             //Quality
	             if (strncmp(buf, "[\"quality\"]", 11)==0)
	             {
	               fscanf(in, " = \" %d \",", &quality);
	             }
	             //Icon
	             if (strncmp(buf, "[\"pic\"]", 7)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(pic, buf, strlen(buf)+1);
	             }
	             //Date
	             if (strncmp(buf, "[\"date\"]", 8)==0)
	             {
	               fscanf(in, " = \" %s \",", buf);
	               strncpy(date, buf, strlen(buf)+1);
	             }
	             //Sender
	             if (strncmp(buf, "[\"from\"]", 8)==0)
	             {
                   fscanf(in, " = \" %s", buf);
	               while (strncmp(buf, "\",", 2)!=0)
	               {
	                 if (sender[0]!='\0')
	                 {
	                   strncat(sender, " ", 1);
                     }
                     strncat(sender, buf, strlen(buf)+1);
	                 fscanf(in, "%s", buf);
                   }
	             }
	             //Type
	             if (strncmp(buf, "[\"type\"]", 10)==0)
	             {
                   fscanf(in, " = \" %s", buf);
	               while (strncmp(buf, "\",", 2)!=0)
	               {
	                 if (type[0]!='\0')
	                 {
	                   strncat(type, " ", 1);
                     }
                     strncat(type, buf, strlen(buf)+1);
	                 fscanf(in, "%s", buf);
                   }
	             }
	             //Subtype
	             if (strncmp(buf, "[\"subtype\"]", 10)==0)
	             {
	               fscanf(in, " = \" %s", buf);
	               while (strncmp(buf, "\",", 2)!=0)
	               {
	                 if (subtype[0]!='\0')
	                 {
	                   strncat(subtype, " ", 1);
                     }
                     strncat(subtype, buf, strlen(buf)+1);
	                 fscanf(in, "%s", buf);
                   }
	             }
	             //Name
	             if (strncmp(buf, "[\"name\"]", 8)==0)
	             {
                   fscanf(in, " = \" %s", buf);
	               while (strncmp(buf, "\",", 2)!=0)
	               {
	                 if (sname[0]!='\0')
	                 {
	                   strncat(sname, "+", 1);
	                   strncat(name, " ", 1);
                     }
	                 strncat(sname, buf, strlen(buf)+1);
	                 strncat(name, buf, strlen(buf)+1);
	                 fscanf(in, "%s", buf);
                   }
                 }
	             //Description
	             if (strncmp(buf, "[\"description\"]", 15)==0)
            	 {
            	   fscanf(in, " = \" %s", buf);
            	   while (strncmp(buf, "<n>", 3)!=0 && strncmp(buf, "\",", 2)!=0)
            	   {
            	     fscanf(in, "%s", buf);
            	   }
            	   while (strncmp(buf, "\",", 2)!=0)
            	   {
            	     if (strncmp(buf, "<n>", 3)==0)
            	     {
            	       strncat(desc, "<br>", 5);
            	       desc_len=0;
            	     }
            	     else
            	     if (strncmp(buf, "<t>", 3)==0)
            	     {
            	       for (i = desc_len; i<40; i++)
            		     strncat(desc, "&nbsp;", 7);
     	               strncat(desc, "\0", 1);
            	     }
            	     else if (strncmp(buf, "<c>", 3)==0)
           	         {
            	       strcat(desc, "</span><span style=\"font-size: 12px;color:#");
                       fscanf(in, "%s", buf);
                       strcat(desc, buf);
                       strcat(desc, ";\">");
              	       strncat(desc, "\0", 1);
     	             }
            	     else
            	     {
            	       strncat(desc, " ", 1);
            	       strncat(desc, buf, strlen(buf)+1);
            	       desc_len+=strlen(buf)+1;
            	     }
            	     fscanf(in, "%s", buf);
            	   }
            	 }
                 //End of variables list
                 
                 fscanf(in, "%s", buf);
                 //If all the variables have been scanned for this item - 
                 //send them to the DB
                 if (strncmp(buf, "},", 2)==0 && name[0]!='\0')
                 {
                   //Removes esc chars infront of every " char in name
                    buf[0]='\0';
                    strcpy(buf, name);
                    name[0]='\0';
                    while(strchr(buf,'\\')!=NULL)
                    {
                      int pos,len;
                      pos = strlen(buf)-strlen(strchr(buf,'\\'));
                      len = strlen(buf);
                      char a[100];
                      a[0]='\0';
                      strncpy(a,buf,pos);
                      a[pos]='\0';
                      strcat(name, a);
                      strncpy(buf, buf+pos+1, len-pos);                   
                    }
                    strcat(name, buf);
                    //Removes esc chars infront of every " char in description
                    strcpy(buf, desc);
                    desc[0]='\0';
                    while(strchr(buf,'\\')!=NULL)
                    {
                      int pos,len;
                      pos = strlen(buf)-strlen(strchr(buf,'\\'));
                      len = strlen(buf);
                      char a[1000];
                      a[0]='\0';
                      strncpy(a,buf,pos);
                      a[pos]='\0';
                      strcat(desc, a);
                      strncpy(buf, buf+pos+1, len-pos);                    
                    }
                    strcat(desc, buf);
                   
                   //Generates HTML code
                   link[0]='\0';
                   strcat(link," <tr bgcolor='#");
                   if ((l%2)==1) strcat(link, "302C24'>\n");
                   else strcat(link,"1B1515'>\n");
                   strcat(link,"  <td width=40 align=center valign=top>\n");
                   strcat(link,"   <a onClick=javascript:window.open(\"");
                   strcat(link, SEARCHSITE);
                   strcat(link, sname);
                   strcat(link,"\",\"blank\",\"\"); style=\"text-decoration: none\">");
                   strcat(link,"<span style=\"position:absolute; cursor:hand;\"><table width=36 height=40 ");
                   strcat(link,"cellpadding=0 cellspacing=0 border=0><tr><td valign=bottom ");
                   strcat(link,"align=right><span style=\"font-size: 12px;color: white; font-weight:bold;\">");
                   if (strncmp(num, "1", 2)!=0 && strncmp(num, "Unknown", 8)!=0 && strncmp(num, "0", 2)!=0 ) strcat(link, num);
                   strcat(link,"</span></td></tr></table></span><img src=\"");
                   strcat(link, IMAGESFOLDER);
                   strcat(link, pic);
                   strcat(link, IMAGEEXTENTION);
                   strcat(link,"\" width=40 height=40 border=0");
                   strcat(link," style=\"margin-right: 0px; border: 0px\"\"></a>\n");
                   strcat(link,"  </td>\n  <td width=260 align=left valign=top>\n");
                   strcat(link,"<span style=\"font-size: 12px;");
                   if (quality==0) strcat(link,"color:#9D9D9D;\"><b>");
                   if (quality==1) strcat(link,"color:#FFFFFF;\"><b>");
                   if (quality==2) strcat(link,"color:#1EFF00;\"><b>");
                   if (quality==3) strcat(link,"color:#0070DD;\"><b>");
                   if (quality==4) strcat(link,"color:#A335EE;\"><b>");
                   if (quality==5) strcat(link,"color:#EE9900;\"><b>");
                   strcat(link, name);
                   strcat(link,"</b></span><span style=\"font-size: 12px; color:white\">");
                   strcat(link, desc);
                   strcat(link,"</span></div><br>\n");
                   strcat(link,"  </td>\n  <td width=100 align=center valign=top>\n<span style=\"color:white\">");
                   sprintf(tmp, "%d<img src=\"", cost/10000);
                   strncat(tmp, STDIMAGESFOLDER, 101);
                   strcat(tmp, "gold.gif\"> ");
                   strcat(link,tmp);
                   sprintf(tmp, "%d<img src=\"", cost/100%100);
                   strncat(tmp, STDIMAGESFOLDER, 101);
                   strcat(tmp, "silver.gif\"> ");
                   strcat(link,tmp);
                   sprintf(tmp, "%d<img src=\"", cost%100);
                   strncat(tmp, STDIMAGESFOLDER, 101);
                   strcat(tmp, "copper.gif\"></span> ");
                   strcat(link,tmp);
                   strcat(link,"  </td>\n  <td width=160 align=letf valign=top>\n<span style=\"color:white\">");
                   strcat(link,sender);
                   strcat(link,"</span>\n  </td>\n  <td width=100 align=center valign=top>\n<span style=\"color:white\">20");
                   strcat(link,date);
                   strcat(link,"</span>\n  </td>\n </tr>\n");
                   fprintf(out, link);
                   //reset store variables for the next scan
                   quality=0;
                   cost = 0;
                   name[0]='\0';
                   sname[0]='\0';
                   num[0]='\0';
                   pic[0]='\0';
                   desc[0]='\0';
                   id[0] = '\0';
                   type[0]='\0';
                   subtype[0]='\0';
                   link[0]='\0';
                   sender[0]='\0';
                   l++;
                   
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
