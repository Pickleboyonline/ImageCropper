/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React, { useRef } from 'react';
import {
  Alert,
  Button,
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import CropperView, { useCropper } from './CropperView';




const App = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
    flex: 1
  };

  const [save] = useCropper();

  const handleOnPress = async () => {
    try {
      let result = await save()
      console.log(result)
      console.warn('save executed, check console logs')
    } catch (e: any) {
      console.error(e)
    }

  }

  return (
    <SafeAreaView style={backgroundStyle}>
      <Button
        title="Execute Save Function"
        onPress={handleOnPress} />

      <CropperView
        url="https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=278%2C340%2C4644%2C3098&q=45&auto=format&w=926&fit=clip"
      />
    </SafeAreaView>
  );
};



const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
