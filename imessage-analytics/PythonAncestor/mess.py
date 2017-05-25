# mess.py
# Lucas Jurgensen
#
# Processes iMessage files, returns details

import string


### Helper Functions ###

def sort_weighted_list(wl):
    """Sorts weighted list wl, largest-weight items first. Does not return
    anything.

    Precondition: all items in wl have the form [key, weight], where weight is
    a number (int or float)."""

    wl.sort(key=_second_item, reverse=True)
    
def _second_item(sublist):
    """Helper for sort_weighted_list.
    Returns: sublist[1].
    Precondition: sublist is a list of length 2"""
    return sublist[1]
    
### Text Conversation Class ###

class Convo(object):
    """ A class which will hold all of the details for a specific iMessage
    conversation with person, (person)
    
    #convo.person => String of person's name in form <"first last"> eg. "Han Solo"
    
    #convo.raw_text => File containing all of the raw text from baskup-records
    
        Han Solo: So where is Chewy?
         @ 2017-03-22 04:32:26 +0000
        Me: Yeah, I haven't seen him recently
         @ 2017-03-22 04:33:55 +0000
        Han Solo: I have checked everywhere
         @ 2017-03-22 04:34:06 +0000
        Me: Well, have you checked the trash compactor? 
         @ 2017-03-22 04:34:33 +0000
    
    
    
    #convo.texts => A list of texts, for each text giving: name, time, words
                eg. ["Han Solo", "2017-03-22 04:32:26", "So where is Chewy?]
                combing list_text, list_name, list_time
                
    #convo.lower => convo.texts but lowercase for the message
                
    #convo.my_texts => A list of just the texts sent by me
    
    #convo.their_texts => A list of just the texts sent by person
                
    #convo.length => The number of text messages in the conversation
    
    #convo.my_num => A dictionary with the prevalence of words as the values
                for me
    
    #convo.their_num => A dictionary with the prevalence of words as the values
                for the person
                
    #convo.my_pop => A list of lists with my words and their occurance
                eg. [["dog", 35], ["cat", 1]]
    
    #convo.their_pop => Same as my_pop except its for their words
    
    
    """
    
    def __init__(self, name):
        """ Name in str form of <"Han Solo"> 
        self.person = name
        """
        
        import string
        
        # person attribute
        self.person = name
        
        # raw_text attribute
        inputfile = open("Baskup-Records/" + name, 'r') # Create a file object in read-only mode.
        raw_text = inputfile.read()
        self.raw_text = raw_text
        inputfile.close() # Close the file.
        
        
        ind_lines = raw_text.split("+0000\n")
        short_lines = ind_lines[:(len(ind_lines)-1)]
        
        # length attribute
        self.length = len(short_lines)
        combined_splits = short_lines
             
        
        # Setting text
        list_text = []
        for message in combined_splits:
            first_divide = message.index(':') + 2
            second_divide = message.index('\n @')
            text = message[first_divide:second_divide - 0]
            list_text.append(text)
            
            
        list_name = [] 
        for message in combined_splits:
            first_divide = message.index(':')
            name = message[:first_divide]
            list_name.append(name)
    
        
        list_time = []
        for message in combined_splits:
            first_divide = message.index('@') + 1
            # second_divide = message.index('+') - 1
            time = message[first_divide:]
            time = time[1:len(time)-1]
            list_time.append(time)
        
        
        texts = []
        for index in range(self.length):
            minilist = []
            minilist.append(list_name[index])
            minilist.append(list_time[index])
            minilist.append(list_text[index])
            texts.append(minilist)
            # texts.insert(0, minilist)
            
            
        self.texts = texts
        
        texts_copy = self.texts
        for pods in texts_copy:
            pods[2] = pods[2].lower()
        self.lower = texts_copy
        
        # setting my_texts and their_texts
        
        my_texts = []
        their_texts = []
        
        for text in self.lower:
            if ('Me' == text[0]):
                my_texts.insert(0, text)
            else:
                their_texts.insert(0, text)
        
        self.my_texts = my_texts
        self.their_texts = their_texts
            
        
        # setting word counter
        my_word_num ={}
        for text in self.my_texts:
            words_list = text[2].split()
            for word in words_list:
                if word in my_word_num:
                    my_word_num[word] += 1
                else:
                    my_word_num[word] = 1
        
        self.my_num = my_word_num
        
        their_word_num ={}
        for text in self.their_texts:
            words_list = text[2].split()
            for word in words_list:
                if word in their_word_num:
                    their_word_num[word] += 1
                else:
                    their_word_num[word] = 1
        
        self.their_num = their_word_num
        
        # Creates lower attribute
        
        texts_copy = self.texts
        for pods in texts_copy:
            pods[2].lower()
        self.lower = texts_copy
        
        # Average words per text
        my_denom = 0
        my_sum = 0
        for group in self.my_texts:
            my_denom += 1
            my_sum += len(group[2].split())
        self.my_avg = (1.0) * my_sum / my_denom
        
        their_denom = 0
        their_sum = 0
        for group in self.their_texts:
            their_denom += 1
            their_sum += len(group[2].split())
        self.their_avg = (1.0) * their_sum / their_denom
        
        # Creates lists in order of word popularity
        self.their_sorted_texts = []
        for text in self.their_num:
            self.their_sorted_texts.append([text,self.their_num[text]])
        self.their_sorted_texts.sort(key=_second_item, reverse=True)
        
        self.my_sorted_texts = []
        for text in self.my_num:
            self.my_sorted_texts.append([text,self.my_num[text]])
        self.my_sorted_texts.sort(key=_second_item, reverse=True)
        
    def popular_words(self, k):
        """Function that shows words that are used more than 'k' times
        """
 
        print "Words by me:"
        for entry in self.my_num:
            if self.my_num[entry] >= k:
                print entry + ": " + str(self.my_num[entry])
                
        print
        print
        print "Words by them:"
        for entry in self.their_num:
            if self.their_num[entry] >= k:
                print entry + ": " + str(self.their_num[entry])
    
    def most_used_words(self, k):
        print "My most popular words: "
        for num in range(k):
            print self.my_sorted_texts[num]
        print
        print "Their most popular words"
        for num in range(k):
            print self.their_sorted_texts[num]        
            
    def specific_word(self, word):
        """Function that gets specific word (word) and shows how many times it
        is said by me and them
        
        Word must be lowercase
        """
        
        print "The word: "+ word
        print "Me: " + str(self.my_num[word])
        print "Them: " + str(self.their_num[word])
        
    def convo_stats(self, k=10):
        print
        print
        print "Processing " + self.person + "'s conversation..."
        print
        print
        print "-----------------------"
        print "Converstaion Statistics"
        print "-----------------------"
        print
        print "Convo Length: " + str(self.length)
        print
        print "I texted: " + str(len(self.my_texts))
        print self.person + " texted: " + str(len(self.their_texts))
        print
        
        my_numerator = (len(self.my_texts) * (self.my_avg))
        their_numerator = (len(self.their_texts) * (self.their_avg))
        our_denominator = my_numerator + their_numerator
        
        print "My texts were " + str((round(my_numerator / our_denominator, 3)) * 100) + "% of the conversation"
        print self.person + "'s texts were " + str((round(their_numerator / our_denominator, 3)) * 100) + "% of the converstaion"
        print
        print "My average words per text: " + str(round(self.my_avg, 3))
        print self.person + "'s average words per text: " + str(round(self.their_avg, 3))
        print
        print
        self.most_used_words(k)
        print
        
            
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        