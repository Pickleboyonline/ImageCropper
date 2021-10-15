import React, { FC } from 'react';
import { requireNativeComponent, NativeModules, Image, Text, Alert } from 'react-native';
const { CropperModule } = NativeModules;
import RNFS from 'react-native-fs';
export const getCroppedImageUri = CropperModule.getCroppedImageUri as (trash: boolean) => Promise<string>;


interface CropperViewProps {
    /**
     * Remote URL of string, required
     */
    url: string,

}

// TODO: Allow multiple instances of CropperViews per app run
// TODO: Create bindings to customize Native TOCropper toolbar
const CropperView: FC<CropperViewProps> = (props) => {
    const { url } = props;
    // let defaultPuppyUrl = "https://www.guidedogs.org/wp-content/uploads/2019/11/website-donate-mobile.jpg";
    CropperModule.setImageUrl(url)

    let NativeTOCropperView = requireNativeComponent('IMGCropper');

    return <NativeTOCropperView
        {...{
            style: {
                flex: 1
            }
        }} />
}

/**
 * Hook for save function. NOTE: Only call when CropperView is mounted,
 * Otherwise the save function will have no reference view.  
 */
export const useCropper = () => {
    return [save]
}


interface SaveOptions {
    /**
     * defaults to base64
     */
    type?: 'uri' | 'base64',
    /**
     * must be between 0 - 1, dafaults to 1
     */
    compressionQuality?: number
}

const getSize = (uri: string) => {
    return new Promise<[number, number]>((res, rej) => {
        Image.getSize(uri, (width, height) => {
            res([width, height])
        }, rej)
    })
}

async function save(options?: SaveOptions) {
    options ||= {};
    options.type ||= 'uri';
    options.compressionQuality ||= 1;

    let base64String = await CropperModule.getCroppedImageUri(options.compressionQuality);
    let base64Image = base64String.split(';base64,').pop();


    // get image dimensions:
    let [width, height] = await getSize('data:image/png;base64,' + base64String);

    if (options.type === 'uri') {
        var path = RNFS.DocumentDirectoryPath + `/cropped-image-${(new Date()).getTime()}.png`;

        await RNFS.writeFile(path, base64Image, 'base64');
        return { uri: path, width, height }
    } else {
        return { base64: base64String, width, height }
    }
}


// requireNativeComponent automatically resolves 'RNTMap' to 'RNTMapManager'
export default CropperView;