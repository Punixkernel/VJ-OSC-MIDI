OSC_Connection_RSL = { false, true, false, false, false }

AutoBPM = true
OSCPath_S2L_BPM = '/s2l/out/bpm'
OSCPath_RSL_BPM = '/composition/tempocontroller/tempo'
OSCPath_RSL_BPMTAP = '/composition/tempocontroller/tempotap'
OSCPath_RSL_BPMRSYNC = '/composition/tempocontroller/resync'
OSCPath_RSL_BPMDBL = '/composition/tempocontroller/tempo/multiply'
OSCPath_RSL_BPMHLF = '/composition/tempocontroller/tempo/divide'

MIDIKEY_AUTOBPM = {176, 42}
MIDIKEY_BPMTAP = {176, 43}
MIDIKEY_BPMRSYNC = {176, 44}
MIDIKEY_BPMDBL = {176, 59}
MIDIKEY_BPMHLF = {176, 58}

MIDIKEY_INIT = {176,46}
MIDIKEY_VDJMST_INIT = {176,60}
MIDIKEY_JITOME = {176,61}
MIDIKEY_CDCLOCK = {176,62}


MIDIKEY_Mst = {176,70}
MIDIKEY_Mst_AlphaMst = {176,54}
MIDIKEY_FlipMst_AlphaMst = {176,38}

MIDIKEY_FlipNdiR_AlphaMst = {176,71}
MIDIKEY_FlipNdiR_AlphaNdiR = {176,55}
MIDIKEY_FlipNdiR_AddNdiR = {176,39}

MIDIKEY_FlipNdiL_AlphaMst = {176,69}
MIDIKEY_FlipNdiL_AlphaNdiL = {176,53}
MIDIKEY_FlipNdiL_AddNdiL = {176,37}


MIDIKEY_MSKTYP_JITOME = {176,68}
MIDIKEY_MSKTYP_CLIP = {176,52}
MIDIKEY_MSKTYP_CAM = {176,36}
MIDIKEY_MSKTYP_CAM2 = {176,35}
MIDIKEY_MSKTYP_LOGO = {176,51}
MIDIKEY_MSKGAIN_L = {176,19}
MIDIKEY_MSKGAIN_R = {176,20}




function onReceiveOSC(message, connections)
  print('onReceiveOSC')
  local path = message[1]
  local arguments = message[2]
  print('\t path        =', path)
  for i=1,#arguments do
    print('\t argument    =', arguments[i].tag, arguments[i].value)
  end
  print('\t connections =', table.unpack(connections))

  if path == OSCPath_S2L_BPM then
    print('BPM osc Message from Sound2Light')
    onReceiveBPM(arguments[1].value)
  else
    print('unknown osc path')
  end
end


function onReceiveMIDI(message, connections)
  print('onReceiveMIDI')
  print('\t message     =', table.unpack(message))
  print('\t connections =', table.unpack(connections))
  recvMIDI_type = message[1]
  recvMIDI_data = message[2]
  recvMIDI_value = message[3]
  print('\t type = ', recvMIDI_type)
  print('\t data = ', recvMIDI_data)
  print('\t value = ', recvMIDI_value)
  for i=1,#message do
    print('\t message    =', message[i])
  end

  if ( (MIDIKEY_AUTOBPM[1] == message[1]) and (MIDIKEY_AUTOBPM[2] == message[2])) then
    toggleAUTOBPM(recvMIDI_value)
  elseif ( (MIDIKEY_BPMTAP[1] == message[1]) and (MIDIKEY_BPMTAP[2] == message[2])) then
    tapBPM(recvMIDI_value)
  elseif ( (MIDIKEY_BPMRSYNC[1] == message[1]) and (MIDIKEY_BPMRSYNC[2] == message[2])) then
    BPMRSYNC(recvMIDI_value)
  elseif ( (MIDIKEY_BPMDBL[1] == message[1]) and (MIDIKEY_BPMDBL[2] == message[2])) then
    BPMDBL(recvMIDI_value)
  elseif ( (MIDIKEY_BPMHLF[1] == message[1]) and (MIDIKEY_BPMHLF[2] == message[2])) then
    BPMHLF(recvMIDI_value)

  elseif ( (MIDIKEY_INIT[1] == message[1]) and (MIDIKEY_INIT[2] == message[2])) then
    INIT(recvMIDI_value)
  elseif ( (MIDIKEY_VDJMST_INIT[1] == message[1]) and (MIDIKEY_VDJMST_INIT[2] == message[2])) then
    VDJMST_INIT(recvMIDI_value)
  elseif ( (MIDIKEY_JITOME[1] == message[1]) and (MIDIKEY_JITOME[2] == message[2])) then
    JITOME(recvMIDI_value)
  elseif ( (MIDIKEY_CDCLOCK[1] == message[1]) and (MIDIKEY_CDCLOCK[2] == message[2])) then
    CDCLOCK(recvMIDI_value)

  elseif ( (MIDIKEY_Mst[1] == message[1]) and (MIDIKEY_Mst[2] == message[2])) then
    Mst(recvMIDI_value)
  elseif ( (MIDIKEY_Mst_AlphaMst[1] == message[1]) and (MIDIKEY_Mst_AlphaMst[2] == message[2])) then
    Mst_AlphaMst(recvMIDI_value)
  elseif ( (MIDIKEY_FlipMst_AlphaMst[1] == message[1]) and (MIDIKEY_FlipMst_AlphaMst[2] == message[2])) then
    FlipMst_AlphaMst(recvMIDI_value)

  elseif ( (MIDIKEY_FlipNdiR_AlphaMst[1] == message[1]) and (MIDIKEY_FlipNdiR_AlphaMst[2] == message[2])) then
    FlipNdiR_AlphaMst(recvMIDI_value)
  elseif ( (MIDIKEY_FlipNdiR_AlphaNdiR[1] == message[1]) and (MIDIKEY_FlipNdiR_AlphaNdiR[2] == message[2])) then
    FlipNdiR_AlphaNdiR(recvMIDI_value)
  elseif ( (MIDIKEY_FlipNdiR_AddNdiR[1] == message[1]) and (MIDIKEY_FlipNdiR_AddNdiR[2] == message[2])) then
    FlipNdiR_AddNdiR(recvMIDI_value)

  elseif ( (MIDIKEY_FlipNdiL_AlphaMst[1] == message[1]) and (MIDIKEY_FlipNdiL_AlphaMst[2] == message[2])) then
    FlipNdiL_AlphaMst(recvMIDI_value)
  elseif ( (MIDIKEY_FlipNdiL_AlphaNdiL[1] == message[1]) and (MIDIKEY_FlipNdiL_AlphaNdiL[2] == message[2])) then
    FlipNdiL_AlphaNdiL(recvMIDI_value)
  elseif ( (MIDIKEY_FlipNdiL_AddNdiL[1] == message[1]) and (MIDIKEY_FlipNdiL_AddNdiL[2] == message[2])) then
    FlipNdiL_AddNdiL(recvMIDI_value)

  elseif ( (MIDIKEY_MSKTYP_JITOME[1] == message[1]) and (MIDIKEY_MSKTYP_JITOME[2] == message[2])) then
    MSKTYP_JITOME(recvMIDI_value)
  elseif ( (MIDIKEY_MSKTYP_CLIP[1] == message[1]) and (MIDIKEY_MSKTYP_CLIP[2] == message[2])) then
    MSKTYP_CLIP(recvMIDI_value)
  elseif ( (MIDIKEY_MSKTYP_CAM[1] == message[1]) and (MIDIKEY_MSKTYP_CAM[2] == message[2])) then
    MSKTYP_CAM(recvMIDI_value)
  elseif ( (MIDIKEY_MSKTYP_CAM2[1] == message[1]) and (MIDIKEY_MSKTYP_CAM2[2] == message[2])) then
    MSKTYP_CAM2(recvMIDI_value)
  elseif ( (MIDIKEY_MSKTYP_LOGO[1] == message[1]) and (MIDIKEY_MSKTYP_LOGO[2] == message[2])) then
    MSKTYP_LOGO(recvMIDI_value)
  elseif ( (MIDIKEY_MSKGAIN_L[1] == message[1]) and (MIDIKEY_MSKGAIN_L[2] == message[2])) then
    MSKGAIN_L(recvMIDI_value)
  elseif ( (MIDIKEY_MSKGAIN_R[1] == message[1]) and (MIDIKEY_MSKGAIN_R[2] == message[2])) then
    MSKGAIN_R(recvMIDI_value)

  else
    --
  end


end


function MSKGAIN_R(data)
  print('MSKGAIL_R(', data, ')')
  if 0 < data then
    gain = data / 127
    sendOSC({'/composition/layers/63/video/opacity', {{tag = 'f', value = gain}}}, OSC_Connection_RSL)
  else
    --
  end
end


function MSKGAIN_L(data)
  print('MSKGAIL_L(', data, ')')
  if 0 < data then
    gain = data / 127
    sendOSC({'/composition/layers/62/video/opacity', {{tag = 'f', value = gain}}}, OSC_Connection_RSL)
  else
    --
  end
end



function MSKTYP_LOGO(data)
  print('MSKTYP_LOGO(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/52/clips/6/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end



function MSKTYP_CAM2(data)
  print('MSKTYP_CAM2(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/52/clips/5/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end


function MSKTYP_CAM(data)
  print('MSKTYP_CAM(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/52/clips/4/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end



function MSKTYP_CLIP(data)
  print('MSKTYP_CLIP(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/52/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end


function MSKTYP_JITOME(data)
  print('MSKTYP_JITOME(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/52/clips/3/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end


function FlipNdiL_AddNdiL(data)
  print('FlipNdiL_AddNdiL(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/clips/5/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/clips/5/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/12/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end


function FlipNdiL_AlphaNdiL(data)
  print('FlipNdiL_AplhaNdiL(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/clips/5/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/12/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end

function FlipNdiL_AlphaMst(data)
  print('FlipNdiL_AplhaMst(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/clips/6/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end


function FlipNdiR_AddNdiR(data)
  print('FlipNdiR_AddNdiR(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/clips/6/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/clips/6/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/13/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end


function FlipNdiR_AlphaNdiR(data)
  print('FlipNdiR_AplhaNdiR(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/clips/6/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/13/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end

function FlipNdiR_AlphaMst(data)
  print('FlipNdiR_AplhaMst(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/clips/6/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end


function FlipMst_AlphaMst(data)
  print('FlipMst_AplhaMst(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end

function Mst_AlphaMst(data)
  print('Mst_AplhaMst(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end


function Mst(data)
  print('Mst(', data, ')')
  if 0 < data then
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/clips/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end

function CDCLOCK(data)
  print('CDCLOCK(', data, ')')
  if 0 < data then
    sendOSC({'/composition/columns/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC('/composition/layers/1/select', OSC_Connection_RSL)
    sendOSC({'/composition/layers/1/clips/4/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/2/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/2/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/3/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/11/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/12/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/13/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/13/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/14/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/15/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/15/clips/3/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/16/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/17/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/18/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/19/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/20/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/21/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/22/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/23/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/24/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/25/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/26/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/27/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/28/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/29/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/30/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/31/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/32/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/33/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/34/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/35/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/36/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/37/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/38/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/39/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/40/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/41/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/42/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/43/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/44/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/45/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/46/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/47/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/48/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/49/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/50/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/53/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end

function JITOME(data)
  print('JITOME(', data, ')')
  if 0 < data then
    sendOSC({'/composition/columns/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC('/composition/layers/1/select', OSC_Connection_RSL)
    sendOSC({'/composition/layers/1/clips/4/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/2/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
--    sendOSC({'/composition/layers/2/clips/5/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/3/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/11/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/12/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/13/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/14/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/15/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/15/clips/3/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/16/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/17/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/18/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/19/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/20/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/21/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/22/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/23/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/24/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/25/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/26/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/27/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/28/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/29/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/30/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/31/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/32/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/33/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/34/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/35/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/36/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/37/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/38/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/39/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/40/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/41/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/42/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/43/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/44/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/45/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/46/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/47/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/48/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/49/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/50/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/53/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end

function VDJMST_INIT(data)
  print('VDJMST(', data, ')')
  if 0 < data then
    sendOSC({'/composition/columns/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC('/composition/layers/1/select', OSC_Connection_RSL)
    sendOSC({'/composition/layers/1/clips/4/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/2/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
--    sendOSC({'/composition/layers/2/clips/5/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/3/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/11/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/12/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/13/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/13/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/14/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/15/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/15/clips/3/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/16/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/17/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/18/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/19/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/20/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/21/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/22/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/23/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/24/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/25/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/26/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/27/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/28/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/29/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/30/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/31/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/32/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/33/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/34/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/35/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/36/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/37/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/38/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/39/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/40/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/41/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/42/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/43/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/44/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/45/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/46/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/47/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/48/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/49/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/50/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/53/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end

function INIT(data)
  print('INIT(', data, ')')
  if 0 < data then
    sendOSC({'/composition/columns/1/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC('/composition/layers/1/select', OSC_Connection_RSL)
    sendOSC({'/composition/layers/1/clips/4/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/2/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/2/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/3/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/4/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/5/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/6/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/7/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/8/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/9/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/10/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/11/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/12/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/13/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/14/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/15/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/15/clips/3/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/16/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/17/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/18/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/19/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/20/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/21/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/22/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/23/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/24/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/25/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/26/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/27/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/28/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/29/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/30/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/31/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/32/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/33/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/34/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/35/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/36/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/37/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/38/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/39/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/40/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/41/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/42/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/43/bypassed', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/44/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/45/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/46/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/47/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/48/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/49/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/50/bypassed', {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
    sendOSC({'/composition/layers/53/clips/2/connect', {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    --
  end
end

function BPMRSYNC(data)
  print('BPMRSYNC(', data, ')')
  if 0 < data then
    sendOSC({OSCPath_RSL_BPMRSYNC, {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    sendOSC({OSCPath_RSL_BPMRSYNC, {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
  end
end

function tapBPM(data)
  print('tapBPM(', data, ')')
  if 0 < data then
    sendOSC({OSCPath_RSL_BPMTAP, {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
    sendOSC({OSCPath_RSL_BPMTAP, {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
  end
end


function BPMDBL(data)
  print('tapBPM(', data, ')')
  if 0 < data then
    sendOSC({OSCPath_RSL_BPMDBL, {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
--    sendOSC({OSCPath_RSL_BPMDBL, {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
  end
end


function BPMHLF(data)
  print('tapBPM(', data, ')')
  if 0 < data then
    sendOSC({OSCPath_RSL_BPMHLF, {{tag = 'i', value = 1}}}, OSC_Connection_RSL)
  else
--    sendOSC({OSCPath_RSL_BPMHLF, {{tag = 'i', value = 0}}}, OSC_Connection_RSL)
  end
end


function toggleAUTOBPM(data)
  print('toggleAUTOBPM(', data, ')')
  print('AutoBPM flag ', AutoBPM)
  if 0 < data then
    AutoBPM = not AutoBPM
  end
  if AutoBPM then
    sendMIDI({MIDIKEY_AUTOBPM[1], MIDIKEY_AUTOBPM[2], 127})
  else
    sendMIDI({MIDIKEY_AUTOBPM[1], MIDIKEY_AUTOBPM[2], 0})
  end
end



function onReceiveBPM(bpm)
  print('onReceiveBPM(', bpm, ')')
  print('AutoBPM flag ', AutoBPM)
  if true == AutoBPM then
    sendOSC({OSCPath_RSL_BPM, {{tag = 'i', value = bpm}}}, OSC_Connection_RSL)
    print('BPM sent to Resolume(', bpm, ')')
  end

end
