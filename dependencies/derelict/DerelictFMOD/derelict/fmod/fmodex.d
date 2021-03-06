/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.fmod.fmodex;

public
{
    import derelict.fmod.fmodextypes;
    import derelict.fmod.fmodexfuncs;
}

private
{
    import derelict.util.loader;
}

class DerelictFMODEXLoader : SharedLibLoader
{
public:
    this()
    {
        super(
            "fmodex.dll",
            "libfmodex.so",
            ""
        );
    }

protected:
    override void loadSymbols()
    {
        bindFunc(cast(void**)&FMOD_Memory_Initialize, "FMOD_Memory_Initialize");
        bindFunc(cast(void**)&FMOD_Memory_GetStats, "FMOD_Memory_GetStats");
        bindFunc(cast(void**)&FMOD_Debug_SetLevel, "FMOD_Debug_SetLevel");
        bindFunc(cast(void**)&FMOD_Debug_GetLevel, "FMOD_Debug_GetLevel");
        bindFunc(cast(void**)&FMOD_File_SetDiskBusy, "FMOD_File_SetDiskBusy");
        bindFunc(cast(void**)&FMOD_File_GetDiskBusy, "FMOD_File_GetDiskBusy");

        bindFunc(cast(void**)&FMOD_System_Create, "FMOD_System_Create");
        bindFunc(cast(void**)&FMOD_System_Release, "FMOD_System_Release");

        bindFunc(cast(void**)&FMOD_System_SetOutput, "FMOD_System_SetOutput");
        bindFunc(cast(void**)&FMOD_System_GetOutput, "FMOD_System_GetOutput");
        bindFunc(cast(void**)&FMOD_System_GetNumDrivers, "FMOD_System_GetNumDrivers");
        bindFunc(cast(void**)&FMOD_System_GetDriverInfo, "FMOD_System_GetDriverInfo");
        bindFunc(cast(void**)&FMOD_System_GetDriverInfoW, "FMOD_System_GetDriverInfoW");
        bindFunc(cast(void**)&FMOD_System_GetDriverCaps, "FMOD_System_GetDriverCaps");
        bindFunc(cast(void**)&FMOD_System_SetDriver, "FMOD_System_SetDriver");
        bindFunc(cast(void**)&FMOD_System_GetDriver, "FMOD_System_GetDriver");
        bindFunc(cast(void**)&FMOD_System_SetHardwareChannels, "FMOD_System_SetHardwareChannels");
        bindFunc(cast(void**)&FMOD_System_SetSoftwareChannels, "FMOD_System_SetSoftwareChannels");
        bindFunc(cast(void**)&FMOD_System_GetSoftwareChannels, "FMOD_System_GetSoftwareChannels");
        bindFunc(cast(void**)&FMOD_System_SetSoftwareFormat, "FMOD_System_SetSoftwareFormat");
        bindFunc(cast(void**)&FMOD_System_GetSoftwareFormat, "FMOD_System_GetSoftwareFormat");
        bindFunc(cast(void**)&FMOD_System_SetDSPBufferSize, "FMOD_System_SetDSPBufferSize");
        bindFunc(cast(void**)&FMOD_System_GetDSPBufferSize, "FMOD_System_GetDSPBufferSize");
        bindFunc(cast(void**)&FMOD_System_SetFileSystem, "FMOD_System_SetFileSystem");
        bindFunc(cast(void**)&FMOD_System_AttachFileSystem, "FMOD_System_AttachFileSystem");
        bindFunc(cast(void**)&FMOD_System_SetAdvancedSettings, "FMOD_System_SetAdvancedSettings");
        bindFunc(cast(void**)&FMOD_System_GetAdvancedSettings, "FMOD_System_GetAdvancedSettings");
        bindFunc(cast(void**)&FMOD_System_SetSpeakerMode, "FMOD_System_SetSpeakerMode");
        bindFunc(cast(void**)&FMOD_System_GetSpeakerMode, "FMOD_System_GetSpeakerMode");
        bindFunc(cast(void**)&FMOD_System_SetCallback, "FMOD_System_SetCallback");

        bindFunc(cast(void**)&FMOD_System_SetPluginPath, "FMOD_System_SetPluginPath");
        bindFunc(cast(void**)&FMOD_System_LoadPlugin, "FMOD_System_LoadPlugin");
        bindFunc(cast(void**)&FMOD_System_UnloadPlugin, "FMOD_System_UnloadPlugin");
        bindFunc(cast(void**)&FMOD_System_GetNumPlugins, "FMOD_System_GetNumPlugins");
        bindFunc(cast(void**)&FMOD_System_GetPluginHandle, "FMOD_System_GetPluginHandle");
        bindFunc(cast(void**)&FMOD_System_GetPluginInfo, "FMOD_System_GetPluginInfo");
        bindFunc(cast(void**)&FMOD_System_SetOutputByPlugin, "FMOD_System_SetOutputByPlugin");
        bindFunc(cast(void**)&FMOD_System_GetOutputByPlugin, "FMOD_System_GetOutputByPlugin");
        bindFunc(cast(void**)&FMOD_System_CreateDSPByPlugin, "FMOD_System_CreateDSPByPlugin");
        bindFunc(cast(void**)&FMOD_System_CreateCodec, "FMOD_System_CreateCodec");

        bindFunc(cast(void**)&FMOD_System_Init, "FMOD_System_Init");
        bindFunc(cast(void**)&FMOD_System_Close, "FMOD_System_Close");

        bindFunc(cast(void**)&FMOD_System_Update, "FMOD_System_Update");

        bindFunc(cast(void**)&FMOD_System_Set3DSettings, "FMOD_System_Set3DSettings");
        bindFunc(cast(void**)&FMOD_System_Get3DSettings, "FMOD_System_Get3DSettings");
        bindFunc(cast(void**)&FMOD_System_Set3DNumListeners, "FMOD_System_Set3DNumListeners");
        bindFunc(cast(void**)&FMOD_System_Get3DNumListeners, "FMOD_System_Get3DNumListeners");
        bindFunc(cast(void**)&FMOD_System_Set3DListenerAttributes, "FMOD_System_Set3DListenerAttributes");
        bindFunc(cast(void**)&FMOD_System_Get3DListenerAttributes, "FMOD_System_Get3DListenerAttributes");
        bindFunc(cast(void**)&FMOD_System_Set3DRolloffCallback, "FMOD_System_Set3DRolloffCallback");
        bindFunc(cast(void**)&FMOD_System_Set3DSpeakerPosition, "FMOD_System_Set3DSpeakerPosition");
        bindFunc(cast(void**)&FMOD_System_Get3DSpeakerPosition, "FMOD_System_Get3DSpeakerPosition");

        bindFunc(cast(void**)&FMOD_System_SetStreamBufferSize, "FMOD_System_SetStreamBufferSize");
        bindFunc(cast(void**)&FMOD_System_GetStreamBufferSize, "FMOD_System_GetStreamBufferSize");

        bindFunc(cast(void**)&FMOD_System_GetVersion, "FMOD_System_GetVersion");
        bindFunc(cast(void**)&FMOD_System_GetOutputHandle, "FMOD_System_GetOutputHandle");
        bindFunc(cast(void**)&FMOD_System_GetChannelsPlaying, "FMOD_System_GetChannelsPlaying");
        bindFunc(cast(void**)&FMOD_System_GetHardwareChannels, "FMOD_System_GetHardwareChannels");
        bindFunc(cast(void**)&FMOD_System_GetCPUUsage, "FMOD_System_GetCPUUsage");
        bindFunc(cast(void**)&FMOD_System_GetSoundRAM, "FMOD_System_GetSoundRAM");
        bindFunc(cast(void**)&FMOD_System_GetNumCDROMDrives, "FMOD_System_GetNumCDROMDrives");
        bindFunc(cast(void**)&FMOD_System_GetCDROMDriveName, "FMOD_System_GetCDROMDriveName");
        bindFunc(cast(void**)&FMOD_System_GetSpectrum, "FMOD_System_GetSpectrum");
        bindFunc(cast(void**)&FMOD_System_GetWaveData, "FMOD_System_GetWaveData");

        bindFunc(cast(void**)&FMOD_System_CreateSound, "FMOD_System_CreateSound");
        bindFunc(cast(void**)&FMOD_System_CreateStream, "FMOD_System_CreateStream");
        bindFunc(cast(void**)&FMOD_System_CreateDSP, "FMOD_System_CreateDSP");
        bindFunc(cast(void**)&FMOD_System_CreateDSPByType, "FMOD_System_CreateDSPByType");
        bindFunc(cast(void**)&FMOD_System_CreateChannelGroup, "FMOD_System_CreateChannelGroup");
        bindFunc(cast(void**)&FMOD_System_CreateSoundGroup, "FMOD_System_CreateSoundGroup");
        bindFunc(cast(void**)&FMOD_System_CreateReverb, "FMOD_System_CreateReverb");

        bindFunc(cast(void**)&FMOD_System_PlaySound, "FMOD_System_PlaySound");
        bindFunc(cast(void**)&FMOD_System_PlayDSP, "FMOD_System_PlayDSP");
        bindFunc(cast(void**)&FMOD_System_GetChannel, "FMOD_System_GetChannel");
        bindFunc(cast(void**)&FMOD_System_GetMasterChannelGroup, "FMOD_System_GetMasterChannelGroup");
        bindFunc(cast(void**)&FMOD_System_GetMasterSoundGroup, "FMOD_System_GetMasterSoundGroup");

        bindFunc(cast(void**)&FMOD_System_SetReverbProperties, "FMOD_System_SetReverbProperties");
        bindFunc(cast(void**)&FMOD_System_GetReverbProperties, "FMOD_System_GetReverbProperties");
        bindFunc(cast(void**)&FMOD_System_SetReverbAmbientProperties, "FMOD_System_SetReverbAmbientProperties");
        bindFunc(cast(void**)&FMOD_System_GetReverbAmbientProperties, "FMOD_System_GetReverbAmbientProperties");

        bindFunc(cast(void**)&FMOD_System_GetDSPHead, "FMOD_System_GetDSPHead");
        bindFunc(cast(void**)&FMOD_System_AddDSP, "FMOD_System_AddDSP");
        bindFunc(cast(void**)&FMOD_System_LockDSP, "FMOD_System_LockDSP");
        bindFunc(cast(void**)&FMOD_System_UnlockDSP, "FMOD_System_UnlockDSP");
        bindFunc(cast(void**)&FMOD_System_GetDSPClock, "FMOD_System_GetDSPClock");

        bindFunc(cast(void**)&FMOD_System_GetRecordNumDrivers, "FMOD_System_GetRecordNumDrivers");
        bindFunc(cast(void**)&FMOD_System_GetRecordDriverInfo, "FMOD_System_GetRecordDriverInfo");
        bindFunc(cast(void**)&FMOD_System_GetRecordDriverInfoW, "FMOD_System_GetRecordDriverInfoW");
        bindFunc(cast(void**)&FMOD_System_GetRecordDriverCaps, "FMOD_System_GetRecordDriverCaps");
        bindFunc(cast(void**)&FMOD_System_GetRecordPosition, "FMOD_System_GetRecordPosition");

        bindFunc(cast(void**)&FMOD_System_RecordStart, "FMOD_System_RecordStart");
        bindFunc(cast(void**)&FMOD_System_RecordStop, "FMOD_System_RecordStop");
        bindFunc(cast(void**)&FMOD_System_IsRecording, "FMOD_System_IsRecording");

        bindFunc(cast(void**)&FMOD_System_CreateGeometry, "FMOD_System_CreateGeometry");
        bindFunc(cast(void**)&FMOD_System_SetGeometrySettings, "FMOD_System_SetGeometrySettings");
        bindFunc(cast(void**)&FMOD_System_GetGeometrySettings, "FMOD_System_GetGeometrySettings");
        bindFunc(cast(void**)&FMOD_System_LoadGeometry, "FMOD_System_LoadGeometry");
        bindFunc(cast(void**)&FMOD_System_GetGeometryOcclusion, "FMOD_System_GetGeometryOcclusion");

        bindFunc(cast(void**)&FMOD_System_SetNetworkProxy, "FMOD_System_SetNetworkProxy");
        bindFunc(cast(void**)&FMOD_System_GetNetworkProxy, "FMOD_System_GetNetworkProxy");
        bindFunc(cast(void**)&FMOD_System_SetNetworkTimeout, "FMOD_System_SetNetworkTimeout");
        bindFunc(cast(void**)&FMOD_System_GetNetworkTimeout, "FMOD_System_GetNetworkTimeout");

        bindFunc(cast(void**)&FMOD_System_SetUserData, "FMOD_System_SetUserData");
        bindFunc(cast(void**)&FMOD_System_GetUserData, "FMOD_System_GetUserData");

        bindFunc(cast(void**)&FMOD_System_GetMemoryInfo, "FMOD_System_GetMemoryInfo");

        bindFunc(cast(void**)&FMOD_Sound_Release, "FMOD_Sound_Release");
        bindFunc(cast(void**)&FMOD_Sound_GetSystemObject, "FMOD_Sound_GetSystemObject");

        bindFunc(cast(void**)&FMOD_Sound_Lock, "FMOD_Sound_Lock");
        bindFunc(cast(void**)&FMOD_Sound_Unlock, "FMOD_Sound_Unlock");
        bindFunc(cast(void**)&FMOD_Sound_SetDefaults, "FMOD_Sound_SetDefaults");
        bindFunc(cast(void**)&FMOD_Sound_GetDefaults, "FMOD_Sound_GetDefaults");
        bindFunc(cast(void**)&FMOD_Sound_SetVariations, "FMOD_Sound_SetVariations");
        bindFunc(cast(void**)&FMOD_Sound_GetVariations, "FMOD_Sound_GetVariations");
        bindFunc(cast(void**)&FMOD_Sound_Set3DMinMaxDistance, "FMOD_Sound_Set3DMinMaxDistance");
        bindFunc(cast(void**)&FMOD_Sound_Get3DMinMaxDistance, "FMOD_Sound_Get3DMinMaxDistance");
        bindFunc(cast(void**)&FMOD_Sound_Set3DConeSettings, "FMOD_Sound_Set3DConeSettings");
        bindFunc(cast(void**)&FMOD_Sound_Get3DConeSettings, "FMOD_Sound_Get3DConeSettings");
        bindFunc(cast(void**)&FMOD_Sound_Set3DCustomRolloff, "FMOD_Sound_Set3DCustomRolloff");
        bindFunc(cast(void**)&FMOD_Sound_Get3DCustomRolloff, "FMOD_Sound_Get3DCustomRolloff");
        bindFunc(cast(void**)&FMOD_Sound_SetSubSound, "FMOD_Sound_SetSubSound");
        bindFunc(cast(void**)&FMOD_Sound_GetSubSound, "FMOD_Sound_GetSubSound");
        bindFunc(cast(void**)&FMOD_Sound_SetSubSoundSentence, "FMOD_Sound_SetSubSoundSentence");
        bindFunc(cast(void**)&FMOD_Sound_GetName, "FMOD_Sound_GetName");
        bindFunc(cast(void**)&FMOD_Sound_GetLength, "FMOD_Sound_GetLength");
        bindFunc(cast(void**)&FMOD_Sound_GetFormat, "FMOD_Sound_GetFormat");
        bindFunc(cast(void**)&FMOD_Sound_GetNumSubSounds, "FMOD_Sound_GetNumSubSounds");
        bindFunc(cast(void**)&FMOD_Sound_GetNumTags, "FMOD_Sound_GetNumTags");
        bindFunc(cast(void**)&FMOD_Sound_GetTag, "FMOD_Sound_GetTag");
        bindFunc(cast(void**)&FMOD_Sound_GetOpenState, "FMOD_Sound_GetOpenState");
        bindFunc(cast(void**)&FMOD_Sound_ReadData, "FMOD_Sound_ReadData");
        bindFunc(cast(void**)&FMOD_Sound_SeekData, "FMOD_Sound_SeekData");

        bindFunc(cast(void**)&FMOD_Sound_SetSoundGroup, "FMOD_Sound_SetSoundGroup");
        bindFunc(cast(void**)&FMOD_Sound_GetSoundGroup, "FMOD_Sound_GetSoundGroup");

        bindFunc(cast(void**)&FMOD_Sound_GetNumSyncPoints, "FMOD_Sound_GetNumSyncPoints");
        bindFunc(cast(void**)&FMOD_Sound_GetSyncPoint, "FMOD_Sound_GetSyncPoint");
        bindFunc(cast(void**)&FMOD_Sound_GetSyncPointInfo, "FMOD_Sound_GetSyncPointInfo");
        bindFunc(cast(void**)&FMOD_Sound_AddSyncPoint, "FMOD_Sound_AddSyncPoint");
        bindFunc(cast(void**)&FMOD_Sound_DeleteSyncPoint, "FMOD_Sound_DeleteSyncPoint");

        bindFunc(cast(void**)&FMOD_Sound_SetMode, "FMOD_Sound_SetMode");
        bindFunc(cast(void**)&FMOD_Sound_GetMode, "FMOD_Sound_GetMode");
        bindFunc(cast(void**)&FMOD_Sound_SetLoopCount, "FMOD_Sound_SetLoopCount");
        bindFunc(cast(void**)&FMOD_Sound_GetLoopCount, "FMOD_Sound_GetLoopCount");
        bindFunc(cast(void**)&FMOD_Sound_SetLoopPoints, "FMOD_Sound_SetLoopPoints");
        bindFunc(cast(void**)&FMOD_Sound_GetLoopPoints, "FMOD_Sound_GetLoopPoints");

        bindFunc(cast(void**)&FMOD_Sound_SetUserData, "FMOD_Sound_SetUserData");
        bindFunc(cast(void**)&FMOD_Sound_GetUserData, "FMOD_Sound_GetUserData");

        bindFunc(cast(void**)&FMOD_Sound_GetMemoryInfo, "FMOD_Sound_GetMemoryInfo");

        bindFunc(cast(void**)&FMOD_Channel_GetSystemObject, "FMOD_Channel_GetSystemObject");
        bindFunc(cast(void**)&FMOD_Channel_Stop, "FMOD_Channel_Stop");
        bindFunc(cast(void**)&FMOD_Channel_SetPaused, "FMOD_Channel_SetPaused");
        bindFunc(cast(void**)&FMOD_Channel_GetPaused, "FMOD_Channel_GetPaused");
        bindFunc(cast(void**)&FMOD_Channel_SetVolume, "FMOD_Channel_SetVolume");
        bindFunc(cast(void**)&FMOD_Channel_GetVolume, "FMOD_Channel_GetVolume");
        bindFunc(cast(void**)&FMOD_Channel_SetFrequency, "FMOD_Channel_SetFrequency");
        bindFunc(cast(void**)&FMOD_Channel_GetFrequency, "FMOD_Channel_GetFrequency");
        bindFunc(cast(void**)&FMOD_Channel_SetPan, "FMOD_Channel_SetPan");
        bindFunc(cast(void**)&FMOD_Channel_GetPan, "FMOD_Channel_GetPan");
        bindFunc(cast(void**)&FMOD_Channel_SetDelay, "FMOD_Channel_SetDelay");
        bindFunc(cast(void**)&FMOD_Channel_GetDelay, "FMOD_Channel_GetDelay");
        bindFunc(cast(void**)&FMOD_Channel_SetSpeakerMix, "FMOD_Channel_SetSpeakerMix");
        bindFunc(cast(void**)&FMOD_Channel_GetSpeakerMix, "FMOD_Channel_GetSpeakerMix");
        bindFunc(cast(void**)&FMOD_Channel_SetSpeakerLevels, "FMOD_Channel_SetSpeakerLevels");
        bindFunc(cast(void**)&FMOD_Channel_GetSpeakerLevels, "FMOD_Channel_GetSpeakerLevels");
        bindFunc(cast(void**)&FMOD_Channel_SetInputChannelMix, "FMOD_Channel_SetInputChannelMix");
        bindFunc(cast(void**)&FMOD_Channel_GetInputChannelMix, "FMOD_Channel_GetInputChannelMix");
        bindFunc(cast(void**)&FMOD_Channel_SetMute, "FMOD_Channel_SetMute");
        bindFunc(cast(void**)&FMOD_Channel_GetMute, "FMOD_Channel_GetMute");
        bindFunc(cast(void**)&FMOD_Channel_SetPriority, "FMOD_Channel_SetPriority");
        bindFunc(cast(void**)&FMOD_Channel_GetPriority, "FMOD_Channel_GetPriority");
        bindFunc(cast(void**)&FMOD_Channel_SetPosition, "FMOD_Channel_SetPosition");
        bindFunc(cast(void**)&FMOD_Channel_GetPosition, "FMOD_Channel_GetPosition");
        bindFunc(cast(void**)&FMOD_Channel_SetReverbProperties, "FMOD_Channel_SetReverbProperties");
        bindFunc(cast(void**)&FMOD_Channel_GetReverbProperties, "FMOD_Channel_GetReverbProperties");
        bindFunc(cast(void**)&FMOD_Channel_SetLowPassGain, "FMOD_Channel_SetLowPassGain");
        bindFunc(cast(void**)&FMOD_Channel_GetLowPassGain, "FMOD_Channel_GetLowPassGain");

        bindFunc(cast(void**)&FMOD_Channel_SetChannelGroup, "FMOD_Channel_SetChannelGroup");
        bindFunc(cast(void**)&FMOD_Channel_GetChannelGroup, "FMOD_Channel_GetChannelGroup");
        bindFunc(cast(void**)&FMOD_Channel_SetCallback, "FMOD_Channel_SetCallback");

        bindFunc(cast(void**)&FMOD_Channel_Set3DAttributes, "FMOD_Channel_Set3DAttributes");
        bindFunc(cast(void**)&FMOD_Channel_Get3DAttributes, "FMOD_Channel_Get3DAttributes");
        bindFunc(cast(void**)&FMOD_Channel_Set3DMinMaxDistance, "FMOD_Channel_Set3DMinMaxDistance");
        bindFunc(cast(void**)&FMOD_Channel_Get3DMinMaxDistance, "FMOD_Channel_Get3DMinMaxDistance");
        bindFunc(cast(void**)&FMOD_Channel_Set3DConeSettings, "FMOD_Channel_Set3DConeSettings");
        bindFunc(cast(void**)&FMOD_Channel_Get3DConeSettings, "FMOD_Channel_Get3DConeSettings");
        bindFunc(cast(void**)&FMOD_Channel_Set3DConeOrientation, "FMOD_Channel_Set3DConeOrientation");
        bindFunc(cast(void**)&FMOD_Channel_Get3DConeOrientation, "FMOD_Channel_Get3DConeOrientation");
        bindFunc(cast(void**)&FMOD_Channel_Set3DCustomRolloff, "FMOD_Channel_Set3DCustomRolloff");
        bindFunc(cast(void**)&FMOD_Channel_Get3DCustomRolloff, "FMOD_Channel_Get3DCustomRolloff");
        bindFunc(cast(void**)&FMOD_Channel_Set3DOcclusion, "FMOD_Channel_Set3DOcclusion");
        bindFunc(cast(void**)&FMOD_Channel_Get3DOcclusion, "FMOD_Channel_Get3DOcclusion");
        bindFunc(cast(void**)&FMOD_Channel_Set3DSpread, "FMOD_Channel_Set3DSpread");
        bindFunc(cast(void**)&FMOD_Channel_Get3DSpread, "FMOD_Channel_Get3DSpread");
        bindFunc(cast(void**)&FMOD_Channel_Set3DPanLevel, "FMOD_Channel_Set3DPanLevel");
        bindFunc(cast(void**)&FMOD_Channel_Get3DPanLevel, "FMOD_Channel_Get3DPanLevel");
        bindFunc(cast(void**)&FMOD_Channel_Set3DDopplerLevel, "FMOD_Channel_Set3DDopplerLevel");
        bindFunc(cast(void**)&FMOD_Channel_Get3DDopplerLevel, "FMOD_Channel_Get3DDopplerLevel");

        bindFunc(cast(void**)&FMOD_Channel_GetDSPHead, "FMOD_Channel_GetDSPHead");
        bindFunc(cast(void**)&FMOD_Channel_AddDSP, "FMOD_Channel_AddDSP");

        bindFunc(cast(void**)&FMOD_Channel_IsPlaying, "FMOD_Channel_IsPlaying");
        bindFunc(cast(void**)&FMOD_Channel_IsVirtual, "FMOD_Channel_IsVirtual");
        bindFunc(cast(void**)&FMOD_Channel_GetAudibility, "FMOD_Channel_GetAudibility");
        bindFunc(cast(void**)&FMOD_Channel_GetCurrentSound, "FMOD_Channel_GetCurrentSound");
        bindFunc(cast(void**)&FMOD_Channel_GetSpectrum, "FMOD_Channel_GetSpectrum");
        bindFunc(cast(void**)&FMOD_Channel_GetWaveData, "FMOD_Channel_GetWaveData");
        bindFunc(cast(void**)&FMOD_Channel_GetIndex, "FMOD_Channel_GetIndex");

        bindFunc(cast(void**)&FMOD_Channel_SetMode, "FMOD_Channel_SetMode");
        bindFunc(cast(void**)&FMOD_Channel_GetMode, "FMOD_Channel_GetMode");
        bindFunc(cast(void**)&FMOD_Channel_SetLoopCount, "FMOD_Channel_SetLoopCount");
        bindFunc(cast(void**)&FMOD_Channel_GetLoopCount, "FMOD_Channel_GetLoopCount");
        bindFunc(cast(void**)&FMOD_Channel_SetLoopPoints, "FMOD_Channel_SetLoopPoints");
        bindFunc(cast(void**)&FMOD_Channel_GetLoopPoints, "FMOD_Channel_GetLoopPoints");

        bindFunc(cast(void**)&FMOD_Channel_SetUserData, "FMOD_Channel_SetUserData");
        bindFunc(cast(void**)&FMOD_Channel_GetUserData, "FMOD_Channel_GetUserData");
        bindFunc(cast(void**)&FMOD_Channel_GetMemoryInfo, "FMOD_Channel_GetMemoryInfo");

        bindFunc(cast(void**)&FMOD_ChannelGroup_Release, "FMOD_ChannelGroup_Release");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetSystemObject, "FMOD_ChannelGroup_GetSystemObject");

        bindFunc(cast(void**)&FMOD_ChannelGroup_SetVolume, "FMOD_ChannelGroup_SetVolume");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetVolume, "FMOD_ChannelGroup_GetVolume");
        bindFunc(cast(void**)&FMOD_ChannelGroup_SetPitch, "FMOD_ChannelGroup_SetPitch");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetPitch, "FMOD_ChannelGroup_GetPitch");
        bindFunc(cast(void**)&FMOD_ChannelGroup_Set3DOcclusion, "FMOD_ChannelGroup_Set3DOcclusion");
        bindFunc(cast(void**)&FMOD_ChannelGroup_Get3DOcclusion, "FMOD_ChannelGroup_Get3DOcclusion");
        bindFunc(cast(void**)&FMOD_ChannelGroup_SetPaused, "FMOD_ChannelGroup_SetPaused");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetPaused, "FMOD_ChannelGroup_GetPaused");
        bindFunc(cast(void**)&FMOD_ChannelGroup_SetMute, "FMOD_ChannelGroup_SetMute");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetMute, "FMOD_ChannelGroup_GetMute");

        bindFunc(cast(void**)&FMOD_ChannelGroup_Stop, "FMOD_ChannelGroup_Stop");
        bindFunc(cast(void**)&FMOD_ChannelGroup_OverrideVolume, "FMOD_ChannelGroup_OverrideVolume");
        bindFunc(cast(void**)&FMOD_ChannelGroup_OverrideFrequency, "FMOD_ChannelGroup_OverrideFrequency");
        bindFunc(cast(void**)&FMOD_ChannelGroup_OverridePan, "FMOD_ChannelGroup_OverridePan");
        bindFunc(cast(void**)&FMOD_ChannelGroup_OverrideReverbProperties, "FMOD_ChannelGroup_OverrideReverbProperties");
        bindFunc(cast(void**)&FMOD_ChannelGroup_Override3DAttributes, "FMOD_ChannelGroup_Override3DAttributes");
        bindFunc(cast(void**)&FMOD_ChannelGroup_OverrideSpeakerMix, "FMOD_ChannelGroup_OverrideSpeakerMix");

        bindFunc(cast(void**)&FMOD_ChannelGroup_AddGroup, "FMOD_ChannelGroup_AddGroup");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetNumGroups, "FMOD_ChannelGroup_GetNumGroups");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetGroup, "FMOD_ChannelGroup_GetGroup");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetParentGroup, "FMOD_ChannelGroup_GetParentGroup");

        bindFunc(cast(void**)&FMOD_ChannelGroup_GetDSPHead, "FMOD_ChannelGroup_GetDSPHead");
        bindFunc(cast(void**)&FMOD_ChannelGroup_AddDSP, "FMOD_ChannelGroup_AddDSP");

        bindFunc(cast(void**)&FMOD_ChannelGroup_GetName, "FMOD_ChannelGroup_GetName");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetNumChannels, "FMOD_ChannelGroup_GetNumChannels");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetChannel, "FMOD_ChannelGroup_GetChannel");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetSpectrum, "FMOD_ChannelGroup_GetSpectrum");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetWaveData, "FMOD_ChannelGroup_GetWaveData");

        bindFunc(cast(void**)&FMOD_ChannelGroup_SetUserData, "FMOD_ChannelGroup_SetUserData");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetUserData, "FMOD_ChannelGroup_GetUserData");
        bindFunc(cast(void**)&FMOD_ChannelGroup_GetMemoryInfo, "FMOD_ChannelGroup_GetMemoryInfo");

        bindFunc(cast(void**)&FMOD_SoundGroup_Release, "FMOD_SoundGroup_Release");
        bindFunc(cast(void**)&FMOD_SoundGroup_GetSystemObject, "FMOD_SoundGroup_GetSystemObject");

        bindFunc(cast(void**)&FMOD_SoundGroup_SetMaxAudible, "FMOD_SoundGroup_SetMaxAudible");
        bindFunc(cast(void**)&FMOD_SoundGroup_GetMaxAudible, "FMOD_SoundGroup_GetMaxAudible");
        bindFunc(cast(void**)&FMOD_SoundGroup_SetMaxAudibleBehavior, "FMOD_SoundGroup_SetMaxAudibleBehavior");
        bindFunc(cast(void**)&FMOD_SoundGroup_GetMaxAudibleBehavior, "FMOD_SoundGroup_GetMaxAudibleBehavior");
        bindFunc(cast(void**)&FMOD_SoundGroup_SetMuteFadeSpeed, "FMOD_SoundGroup_SetMuteFadeSpeed");
        bindFunc(cast(void**)&FMOD_SoundGroup_GetMuteFadeSpeed, "FMOD_SoundGroup_GetMuteFadeSpeed");
        bindFunc(cast(void**)&FMOD_SoundGroup_SetVolume, "FMOD_SoundGroup_SetVolume");
        bindFunc(cast(void**)&FMOD_SoundGroup_GetVolume, "FMOD_SoundGroup_GetVolume");
        bindFunc(cast(void**)&FMOD_SoundGroup_Stop, "FMOD_SoundGroup_Stop");

        bindFunc(cast(void**)&FMOD_SoundGroup_GetName, "FMOD_SoundGroup_GetName");
        bindFunc(cast(void**)&FMOD_SoundGroup_GetNumSounds, "FMOD_SoundGroup_GetNumSounds");
        bindFunc(cast(void**)&FMOD_SoundGroup_GetSound, "FMOD_SoundGroup_GetSound");
        bindFunc(cast(void**)&FMOD_SoundGroup_GetNumPlaying, "FMOD_SoundGroup_GetNumPlaying");

        bindFunc(cast(void**)&FMOD_SoundGroup_GetUserData, "FMOD_SoundGroup_GetUserData");
        bindFunc(cast(void**)&FMOD_SoundGroup_SetUserData, "FMOD_SoundGroup_SetUserData");
        bindFunc(cast(void**)&FMOD_SoundGroup_GetMemoryInfo, "FMOD_SoundGroup_GetMemoryInfo");

        bindFunc(cast(void**)&FMOD_DSP_Release, "FMOD_DSP_Release");
        bindFunc(cast(void**)&FMOD_DSP_GetSystemObject, "FMOD_DSP_GetSystemObject");

        bindFunc(cast(void**)&FMOD_DSP_AddInput, "FMOD_DSP_AddInput");
        bindFunc(cast(void**)&FMOD_DSP_DisconnectFrom, "FMOD_DSP_DisconnectFrom");
        bindFunc(cast(void**)&FMOD_DSP_DisconnectAll, "FMOD_DSP_DisconnectAll");
        bindFunc(cast(void**)&FMOD_DSP_Remove, "FMOD_DSP_Remove");
        bindFunc(cast(void**)&FMOD_DSP_GetNumInputs, "FMOD_DSP_GetNumInputs");
        bindFunc(cast(void**)&FMOD_DSP_GetNumOutputs, "FMOD_DSP_GetNumOutputs");
        bindFunc(cast(void**)&FMOD_DSP_GetInput, "FMOD_DSP_GetInput");
        bindFunc(cast(void**)&FMOD_DSP_GetOutput, "FMOD_DSP_GetOutput");

        bindFunc(cast(void**)&FMOD_DSP_SetActive, "FMOD_DSP_SetActive");
        bindFunc(cast(void**)&FMOD_DSP_GetActive, "FMOD_DSP_GetActive");
        bindFunc(cast(void**)&FMOD_DSP_SetBypass, "FMOD_DSP_SetBypass");
        bindFunc(cast(void**)&FMOD_DSP_GetBypass, "FMOD_DSP_GetBypass");
        bindFunc(cast(void**)&FMOD_DSP_SetSpeakerActive, "FMOD_DSP_SetSpeakerActive");
        bindFunc(cast(void**)&FMOD_DSP_GetSpeakerActive, "FMOD_DSP_GetSpeakerActive");
        bindFunc(cast(void**)&FMOD_DSP_Reset, "FMOD_DSP_Reset");

        bindFunc(cast(void**)&FMOD_DSP_SetParameter, "FMOD_DSP_SetParameter");
        bindFunc(cast(void**)&FMOD_DSP_GetParameter, "FMOD_DSP_GetParameter");
        bindFunc(cast(void**)&FMOD_DSP_GetNumParameters, "FMOD_DSP_GetNumParameters");
        bindFunc(cast(void**)&FMOD_DSP_GetParameterInfo, "FMOD_DSP_GetParameterInfo");
        bindFunc(cast(void**)&FMOD_DSP_ShowConfigDialog, "FMOD_DSP_ShowConfigDialog");

        bindFunc(cast(void**)&FMOD_DSP_GetInfo, "FMOD_DSP_GetInfo");
        bindFunc(cast(void**)&FMOD_DSP_GetType, "FMOD_DSP_GetType");
        bindFunc(cast(void**)&FMOD_DSP_SetDefaults, "FMOD_DSP_SetDefaults");
        bindFunc(cast(void**)&FMOD_DSP_GetDefaults, "FMOD_DSP_GetDefaults");

        bindFunc(cast(void**)&FMOD_DSP_SetUserData, "FMOD_DSP_SetUserData");
        bindFunc(cast(void**)&FMOD_DSP_GetUserData, "FMOD_DSP_GetUserData");
        bindFunc(cast(void**)&FMOD_DSP_GetMemoryInfo, "FMOD_DSP_GetMemoryInfo");

        bindFunc(cast(void**)&FMOD_DSPConnection_GetInput, "FMOD_DSPConnection_GetInput");
        bindFunc(cast(void**)&FMOD_DSPConnection_GetOutput, "FMOD_DSPConnection_GetOutput");
        bindFunc(cast(void**)&FMOD_DSPConnection_SetMix, "FMOD_DSPConnection_SetMix");
        bindFunc(cast(void**)&FMOD_DSPConnection_GetMix, "FMOD_DSPConnection_GetMix");
        bindFunc(cast(void**)&FMOD_DSPConnection_SetLevels, "FMOD_DSPConnection_SetLevels");
        bindFunc(cast(void**)&FMOD_DSPConnection_GetLevels, "FMOD_DSPConnection_GetLevels");

        bindFunc(cast(void**)&FMOD_DSPConnection_SetUserData, "FMOD_DSPConnection_SetUserData");
        bindFunc(cast(void**)&FMOD_DSPConnection_GetUserData, "FMOD_DSPConnection_GetUserData");
        bindFunc(cast(void**)&FMOD_DSPConnection_GetMemoryInfo, "FMOD_DSPConnection_GetMemoryInfo");

        bindFunc(cast(void**)&FMOD_Geometry_Release, "FMOD_Geometry_Release");

        bindFunc(cast(void**)&FMOD_Geometry_AddPolygon, "FMOD_Geometry_AddPolygon");
        bindFunc(cast(void**)&FMOD_Geometry_GetNumPolygons, "FMOD_Geometry_GetNumPolygons");
        bindFunc(cast(void**)&FMOD_Geometry_GetMaxPolygons, "FMOD_Geometry_GetMaxPolygons");
        bindFunc(cast(void**)&FMOD_Geometry_GetPolygonNumVertices, "FMOD_Geometry_GetPolygonNumVertices");
        bindFunc(cast(void**)&FMOD_Geometry_SetPolygonVertex, "FMOD_Geometry_SetPolygonVertex");
        bindFunc(cast(void**)&FMOD_Geometry_GetPolygonVertex, "FMOD_Geometry_GetPolygonVertex");
        bindFunc(cast(void**)&FMOD_Geometry_SetPolygonAttributes, "FMOD_Geometry_SetPolygonAttributes");
        bindFunc(cast(void**)&FMOD_Geometry_GetPolygonAttributes, "FMOD_Geometry_GetPolygonAttributes");

        bindFunc(cast(void**)&FMOD_Geometry_SetActive, "FMOD_Geometry_SetActive");
        bindFunc(cast(void**)&FMOD_Geometry_GetActive, "FMOD_Geometry_GetActive");
        bindFunc(cast(void**)&FMOD_Geometry_SetRotation, "FMOD_Geometry_SetRotation");
        bindFunc(cast(void**)&FMOD_Geometry_GetRotation, "FMOD_Geometry_GetRotation");
        bindFunc(cast(void**)&FMOD_Geometry_SetPosition, "FMOD_Geometry_SetPosition");
        bindFunc(cast(void**)&FMOD_Geometry_GetPosition, "FMOD_Geometry_GetPosition");
        bindFunc(cast(void**)&FMOD_Geometry_SetScale, "FMOD_Geometry_SetScale");
        bindFunc(cast(void**)&FMOD_Geometry_GetScale, "FMOD_Geometry_GetScale");
        bindFunc(cast(void**)&FMOD_Geometry_Save, "FMOD_Geometry_Save");

        bindFunc(cast(void**)&FMOD_Geometry_SetUserData, "FMOD_Geometry_SetUserData");
        bindFunc(cast(void**)&FMOD_Geometry_GetUserData, "FMOD_Geometry_GetUserData");
        bindFunc(cast(void**)&FMOD_Geometry_GetMemoryInfo, "FMOD_Geometry_GetMemoryInfo");

        bindFunc(cast(void**)&FMOD_Reverb_Release, "FMOD_Reverb_Release");
        bindFunc(cast(void**)&FMOD_Reverb_Set3DAttributes, "FMOD_Reverb_Set3DAttributes");
        bindFunc(cast(void**)&FMOD_Reverb_Get3DAttributes, "FMOD_Reverb_Get3DAttributes");
        bindFunc(cast(void**)&FMOD_Reverb_SetProperties, "FMOD_Reverb_SetProperties");
        bindFunc(cast(void**)&FMOD_Reverb_GetProperties, "FMOD_Reverb_GetProperties");
        bindFunc(cast(void**)&FMOD_Reverb_SetActive, "FMOD_Reverb_SetActive");
        bindFunc(cast(void**)&FMOD_Reverb_GetActive, "FMOD_Reverb_GetActive");

        bindFunc(cast(void**)&FMOD_Reverb_SetUserData, "FMOD_Reverb_SetUserData");
        bindFunc(cast(void**)&FMOD_Reverb_GetUserData, "FMOD_Reverb_GetUserData");
        bindFunc(cast(void**)&FMOD_Reverb_GetMemoryInfo, "FMOD_Reverb_GetMemoryInfo");
    }
}

DerelictFMODEXLoader DerelictFMODEX;

static this()
{
    DerelictFMODEX = new DerelictFMODEXLoader;
}

static ~this()
{
    if(SharedLibLoader.isAutoUnloadEnabled())
        DerelictFMODEX.unload();
}