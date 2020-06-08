param 
(
    $trace,
    $filter = "tcp.port==443"
)

$tsharkpath = $env:ProgramFiles + "\wireshark\tshark.exe"
$outfile = (dir $trace).basename + ".tsv"


& $tsharkpath `
    -r $trace -Y $filter `
    -E header=y -E separator='/t' `
    -T fields -e frame.number -e frame.time -e ip.src -e ip.dst -e tcp.srcport -e tcp.dstport `
    -e tcp.stream -e tcp.len -e tcp.seq -e tcp.ack -e tcp.nxtseq -e tcp.window_size_scalefactor -e tcp.window_size `
    -e tcp.flags.fin -e tcp.flags.syn -e tcp.flags.reset -e tcp.flags.push -e tcp.flags.ack `
    -e tcp.analysis.bytes_in_flight -e tcp.analysis.push_bytes_sent -e tcp.analysis.acks_frame -e tcp.analysis.ack_rtt -e tcp.analysis.initial_rtt `
    -e tcp.analysis.retransmission -e tcp.analysis.fast_retransmission `
    -e tcp.analysis.duplicate_ack -e tcp.analysis.duplicate_ack_frame -e tcp.analysis.duplicate_ack_num `
    -e tcp.analysis.keep_alive -e tcp.analysis.keep_alive_ack -e tcp.analysis.lost_segment -e tcp.analysis.flags -e tcp.analysis `
    | out-file -FilePath $outfile -Encoding ASCII


